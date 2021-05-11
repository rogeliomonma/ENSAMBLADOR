.model small
.stack 
CR EQU 13 ;RETORNO DE CARRO DEFINIDO EN UNA VARIABLE QUE ES CR CON SU VALOR DECIMAL DE LA TABLA ASCII 10
LF EQU 10 ;SALTO DE LINEA DEFINIDO EN UNA VARIABLE QUE ES LF CON SU VALOR DECIMAL DE LA TABLA ASCII 13
HT EQU 09 ;TABULACION HORIZONTAL.
.data
;Declaracion de variables para almacenamiento temportal de datos ingresados por el usuario
u db 0
d db 0
;Declaracion de variables para almacenamiento temportal para resgistro de impreción del resultado
unidades db 0
decenas db 0
centenas db 0
;Declaración de variable temportal para almacenar el resultado
res db 0    
;Declaracion de una cadena               
texto db LF,CR,HT,"Ingresa un numero:$",0dh,0ah
;Declaración para almacenar numeros temporales
num db 0,LF ;Variable para reslpaldar el número digitado por el usuario.
.code
inicio:
    MOV AX,@data        ;MOVEMOS EL SEGMENTO DE DATOS A AX=ACOMULADOR
    MOV DS,AX           ;MOVEMOS AX A DS=RESGISTRO DE SEGMENTO DE DATOS 
    MOV DX,OFFSET texto ;MOVEMOS  AL DX=REGISTRO DE DATOS LA CADENA0 EN UNA POSICION SUMADAS DE UNA DIRECCION BASE EN TERMINOS GENERALES LE DA UNA POSICION NUEVA
    MOV AH,09h          ;POCION DEL CURSOR PARA VISUALIZAR LA CADENA DE CARACTERES
    INT 21H             ;INTERRUPCION DE INVOCACION DE SERVICIOS DEL DOS
    ;Pedir el número al usuario
    mov ah,01h  
    int 21h
    sub al,30h
    ;guardamos el número digitado en d.
    mov d,al 
    ;Pedir el número al usuario
    mov ah,01h  
    int 21h
    sub al,30h
    ;guardamos el número digitado en u.
    mov u,al 
    mov al,d
    mov bl,10 ;Multiplicación de decenas por 10.
    mul bl
    add al,u  ;Sumar decenas a las unidades
    mov num,al
    mov cl,01h ;Iniciamos el contador en 1
    ;Imprecion de salto de linea
    mov ah,02h
    mov dl,LF
    int 21h
tabla: 
    ;Aguste ASCII para separar en lumero en dos dijitos decenas y unidades
    mov al,num 
    AAM
    mov bx,ax                 
    mov ah,02h                          
    mov dl,bh                   
    add dl,30h           
    int 21h
    mov ah,02h
    mov dl,bl
    add dl,30h
    int 21h
    ;Imprecion de una x
    mov ah,02h                    
    mov dl,"x"                  
    int 21h
    ;Ajuste ASCII para impreción de multiplicador en unidades y decenas
    mov al,cl               
    AAM                
    mov bx,ax    
    mov ah,02h                
    mov dl,bh               
    add dl,30h      
    int 21h
    mov ah,02h
    mov dl,bl
    add dl,30h
    int 21h
    ;Imprecion de un igual
    mov ah,02h                    
    mov dl,"="                   
    int 21h
    ;Ajuste ASCII para impreción de multiplicador en unidades,decenas y centenas
    mov al,num
    mov bl,cl
    mul bl    
    mov res,al                
    mov al,res     
    AAM      
    mov unidades,al
    mov al,ah
    AAM
    mov centenas,ah
    mov decenas,al
    ;Imprecion de centenas
    mov ah,02h     
    mov dl,centenas  
    add dl,30h      
    int 21h
    ;Impreción de decenas
    mov ah,02h
    mov dl,decenas
    add dl,30h
    int 21h
    ;Imprecion de unidades
    mov ah,02h
    mov dl,unidades
    add dl,30h
    int 21h
    ;Impreción de salto de linea
    mov ah,02h                    
    mov dl,LF                   
    int 21h
    inc cx    ;Incrementa nuestro contador en 1
    cmp cx,10 ;compara contador igual a 10
    ja salir  ; Si es mayor sale del programa
    jmp tabla ; Si es menor se repite el ciclo.
salir:
    mov ah,4ch
    int 21h

end inicio
