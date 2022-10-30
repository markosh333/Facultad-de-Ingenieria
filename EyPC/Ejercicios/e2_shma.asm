; e2_shma.asm 
;
; Author: Marco Antonio Sanchez Hernandez
; Date: 29-Oct-2022

title "Direccionamiento directo y de registros"
.model small			; Directiva de modelo de memoria, small => 64KB para memoria de programa y 64KB para memoria de datos
.386					; Directiva para indicar version del procesador
.stack 64				; Definicion de tamaño del segmento de pila (64 bytes)
.data					; Definicion del segmento de datos
	var		dw	0h		; Variable auxiliar
.code					; Definicion del segmento de codigo
	inicio:				; Etiqueta inicio
		mov ax, @data	; AX = directiva @data, @data es una variable de sistema que contiene la direccion del segmento de datos
		mov ds, ax		; DS = AX, inicializa segmento de datos

		mov ax, 43ABh	; AX = 43ABh
		mov bx, 0EDF3h	; BX = EDF3h
		mov cx, 0001h	; CX = 0001h
		mov dx, 1000h	; DX = 1000h

		mov [var], ax	; [var] = AX =43ABh
		mov ax, cx		; AX = CX = 0001h
		mov cx, [var]	; CX = var = 43ABh
		mov [var], bx	; [var] = BX = EDF3h
		mov bx, dx		; BX = DX = 1000h
		mov dx, [var]	; DX = var = EDF3h
	salir:				; Etiqueta salir
		mov ah, 4Ch		; AH = 4Ch, opcion para terminar programa
		mov al, 0		; AL = 0, Exit Code, codigo devuelto al finalizar el programa

		int 21h			; Señal 21h de interrupcion, pasa el control al sistema operativo
		end inicio		; Fin de etiqueta inicio, fin del programa
