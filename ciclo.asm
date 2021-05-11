model small
.stack 64
CR EQU 13 			;RETORNO DE CARRO DEFINIDO EN UNA VARIABLE QUE ES CR CON SU VALOR DECIMAL DE LA TABLA ASCII 10
LF EQU 10 			;SALTO DE LINEA DEFINIDO EN UNA VARIABLE QUE ES LF CON SU VALOR DECIMAL DE LA TABLA ASCII 13
HT EQU 09 			;TABULACION HORIZONTAL.
.data 		
					;Declaración de cadenas
  titulo db LF, CR,HT,"Implemetacion de ciclo que imprima un mensaje n veces", "$"
  numero  db LF, CR,"Ingresa un numero:", "$"
  mensaje db LF, CR,"El ciclo se encuencuentra en su index-->", "$" 
  					;Declaración de variables
  num db ?
  u db 0   
  d db 0
.code
mov ax,@data
mov ds,ax
lectura:
    MOV AX,@data	;MOVEMOS EL SEGMENTO DE DATOS A AX=ACOMULADOR
    MOV DS,Ax 		;MOVEMOS AX A DS=RESGISTRO DE SEGMENTO DE DATOS 
    MOV DX,OFFSET titulo 	;MOVEMOS  AL DX=REGISTRO DE DATOS LA CADENA0 EN UNA POSICION SUMADAS DE UNA DIRECCION BASE EN TERMINOS GENERALES LE DA UNA POSICION NUEVA
    MOV AH,09h         	    ;POCION DEL CURSOR PARA VISUALIZAR LA CADENA DE CARACTERES
    INT 21H           		;INTERRUPCION DE INVOCACION DE SERVICIOS DEL DOS
    MOV DX,OFFSET numero    ;MOVEMOS  AL DX=REGISTRO DE DATOS LA CADENA0 EN UNA POSICION SUMADAS DE UNA DIRECCION BASE EN TERMINOS GENERALES LE DA UNA POSICION NUEVA
    MOV AH,09h       	   	;POCION DEL CURSOR PARA VISUALIZAR LA CADENA DE CARACTERES
    INT 21H           		;INTERRUPCION DE INVOCACION DE SERVICIOS DEL DOS
   							;Pedir el número al usuario
    mov ah,01h  			
    int 21h
    sub al,30h
    mov d,al 		;Guardamos en numero en la variable de decenas
   							;Pedir el número al usuario
    mov ah,01h  
    int 21h
    sub al,30h
    mov u,al 		;Guardamos en numero en la variable de decenas
   							;Concatenación de numeros leidos.
    mov al,d
    mov bl,10 ;Multiplicamos por 10 las decenas.
    mul bl
    add al,u  ;Unimos al con las unidades
    						;Resultado de la concatenación almacenada en una variable
    mov num,al
   							;Iniciamos el contador en 0
    mov cl,0 

ciclo:
;lectura de la cadena desde nuestro segmento de datos
  mov dx,offset mensaje 
  mov ah, 09h
  int 21h
;Gneracion de ciclo por decenas y unidades con un ajuste ASCII
    mov al,cl
    aam
    mov d,al
    mov u,ah
    mov ah,02h
    mov dl,u
    add dl,30h
    int 21h
;Impreción del numero del ciclo en su index
    mov ah,02h
    mov dl,d
    add dl,30h
    int 21h
 ;Incremento de cl en 1
    inc cl
 ;Comparación de cl con el numero ingresado en teclado
    cmp cl,num 
;Si cl es menor que numero ingresado por usuario saltar a cilo si no terminar el programa
	 jl ciclo
     mov ah,04ch ;Al terminar finaliza el programa.
	 int 21h
end
