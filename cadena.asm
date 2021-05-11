.model small
.stack 64
.data
;Declaracion de cadenas 
inicio db 'Lectura de cadenas..',10,13,'$'
ingresar db 10,13,'Ingresa una cadena', 10,13,'$'
nombre db 'La cadena ingresada es: $'
;Declaracion del vector
vtext db 100 dup('$')

.code
        mov ax,@data
        MOV DS,AX
        lea dx,inicio
        mov ah,09
        int 21h

        lea dx,ingresar
        mov ah,09
        int 21h

       ;Iniciamos nuestro conteo de si en la posicion 0.
        mov si,00h
 leer:
        mov ax,0000
        mov ah,01h
        int 21h
        ;Guardamos el valor tecleado por el usuario en la posicion si del vector.
        mov vtext[si],al
        inc si   ;Incrementamos nuestro contador
        cmp al,0dh  ;Comparamos a all con enter
        ;Se repite el ingreso de datos hasta que se teclee un Enter.
        ja leer
        jb leer
        lea dx,nombre
        mov ah,09
        int 21h
        ;Imprime el contenido del vector con la misma instrucción de una cadena
        mov dx,offset vtext  
        mov ah,09h
        int 21h 
          
    ;Teminación de programa
    mov ah,4ch
    int 21h           

end
