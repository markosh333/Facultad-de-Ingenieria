; **************************************************
; * t3_shma.asm									   *
; * Autor: Marco Antonio Sanchez Hernandez         *
; * Fecha: 5/12/2022                               *
; * Descripcion: programa para invertir una cadena *
; **************************************************

title "Invertir cadena"
.model small	; Directiva de modelo de memoria, small => 64 KB memoria de programa y 64 KB memoria de datos
.386			; Directiva para indicar la version del procesador
.stack 64		; Define el tamanio de segmento de pila, 64 bytes

.data			; Definicion del segmento de datos
	cadena	db	0ADh,"Hola, otra vez!$"
	newline	db	0Ah,"$"

.code			; Definicion del segmento de codigo
	inicio:				; Etiqueta inicio
		mov ax,@data	; AX = directiva @data, es una variable del sistema la cual contiene la direccion del segmento de datos
		mov ds,ax		; DS = AX inicializa el segmento de datos

		lea dx,cadena	; Cargar la direccion de memoria de la primera localidad de la variable cadena en DX
		mov ah,09h		; AH = 9h. Escribir caracter con los atributos especificados desde la posicion actual del cursor
		xor al,al		; AL = 0h
		mov cx,10h		; Numero de caracteres a imprimir con los atributos especificados
		mov bl,01h		; Color 0Ah -> verde claro
		int 10h			; Interrupcion 10h. Interrupcion de BIOS
		int 21h			; Interrupcion 21h. Imprimir cadena

		lea si,cadena	; Cargar la direccion de memoria de la primera localidad de la variable cadena en SI
		mov cx,0h		; CX = 0h. CX servira para contar el numero de caracteres en la cadena

		recorrercadena:	; Etiqueta recorrercadena
		mov ax,[si]		; Carga el contenido de SI en AX
		cmp al,'$'		; Verificar si es el final de la cadena
		je invierte		; Si es el final de la cadena salta a procedimiento
		push ax			; Inserta en la pila AX
		inc si			; Incrementa en uno SI para acceder al siguiente caracter
		inc cx			; Incrementa el contador en uno

		jmp recorrercadena	; Salta a recorrercadena

		invierte:		; Etiqueta invierte
		lea si,cadena	; Cargar la direccion de memoria de la primera localidad de la variable cadena en DX

		invertircadena:	; Etiqueta invertircadena
		cmp cx,0		; Compara si el contador es cero
		je imprime		; Si el contador es igual a cero salta a imprime
		
		pop dx			; Saca el valor almacenado en el tope de la pila y lo almacena en DX
		xor dh,dh		; DH = 0h
		mov [si],dx		; Almacena el contenido de DX en la localidad de memoria a la cual apunta SI
		inc si			; Incrementa en un SI para acceder a la siguiente localidad de memoria
		dec cx			; Decrementa en uno el contador

		jmp invertircadena	; Salta a invertircadena

		imprime:		; Etiqueta imprime
		lea dx,newline	; Cargar la direccion de memoria de la primera localidad de la variable cadena en DX
		mov ax,0900h	; AX = 0900h, opcion 9h para interrupcion 21h
		int 21h			; Interrupcion 21h. Imprimir cadena

		mov ax,'$'		; AX = '$'
		mov [si],ax		; Mueve '$' al final de la cadena para indicar su final

		lea dx,cadena	; Cargar la direccion de memoria de la primera localidad de la variable cadena en DX
		mov ah,09h		; AH = 9h. Escribir caracter con los atributos especificados desde la posicion actual del cursor
		xor al,al		; AL = 0h
		mov cx,10h		; Numero de caracteres a imprimir con los atributos especificados
		mov bl,04h		; Color 04h -> verde claro
		int 10h			; Interrupcion 10h. Interrupcion de BIOS
		int 21h			; Interrupcion 21h. Imprimir cadena
	salir:				; Etiqueta salir
		mov ah,4Ch		; AH = 4Ch. Opcion para terminar programa
		mov al,0		; AL = 0h. Codigo de retorno al finalizar la ejecucion del programa
		int 21h			; Senial de interrupcion 21h, pasa el control al sistema operativo
	end inicio			; Fin de etiqueta inicio, fin del programa
