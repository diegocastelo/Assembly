;1. Leia um arquivo com três números inteiros
;   no intervalo [100,999];
;2. Realize a soma desses números;
;3. Crie um novo arquivo de output;
;4. Escreva o resultado nesse novo
;   arquivo.

org 100h
;Abrir o arquivo que vou ler:
    mov al, 0
    mov dx, offset inputFile
    mov ah, 3dh
	int 21h
	;fd no AX
	push ax
	
;Ler o arquivo:
    mov bx, ax
    mov cx, bsize
    mov dx, offset buffer
    mov ah, 3Fh
    int 21h
    
;Realiza a soma dos números
;Obs: Eu li uma string, preciso transformar
;     em inteiros
        
    mov si, 0
    mov [resultado], si
    loop_1:
        mov bx, 100
        loop_2:
        
            ;resultado = resultado + bx * buffer[si]  
            mov ax, 0
            mov al, [buffer + si]
            sub al, '0'
            mul bx
            add [resultado], ax
            
            ;bx = bx // 10 (divisão inteira)
            mov ax, bx
            mov bx, divisor
            div bx
            mov bx, ax
            
            ;Verifico se finalizei o parsing de
            ;um número (li uma vírgula)
            inc si
            mov al, [buffer + si]
            cmp al, ','
            je mult_3
            jne mult_2:
            mult_2:
               ;Se não li vírgula, é o final?
               cmp si, 12
               ;Se for final, fecho o arquivo
               je fechar
               ;C.C leia mais um dígito
               jne loop_2
    mult_3: 
        ;Se li uma vírgula, comece a leitura
        ;do próximo número
        inc si
        cmp si, 12
        jl loop_1
      
;Fechar o arquivo
    fechar:
    pop bx
    mov ah, 3Eh
    int 21h

;Transformar de inteiro p/ string
mov bx, [resultado]
mov si, 0
loop_3:
    xor dx, dx
    mov ax, bx
    mov bx, divisor
    div bx
    mov bx, ax
    add dl, '0'
    mov [iresultado + si], dl
    inc si
    cmp ax, 10
    jg loop_3

add ax, '0'
mov [iresultado + si], al
mov bx, 0
loop_4:
    mov al, [iresultado + si]
    mov [sresultado + bx], al
    dec si
    inc bx
cmp si, 0
jge loop_4 


;Criar um arquivo
	mov cx, 0
	mov dx, offset outputFile
	mov ah, 3ch
	int 21h

    mov bx, ax
    push bx  ;bx -> memória
    mov dx, offset sresultado
    mov ah, 40h
    mov cx, 5
    int 21h
    
    ;Fechar o arquivo
    pop bx  ;bx <- file handle (Stack da Memória)
    mov ah, 3eh
    int 21h  



ret
;section .data
inputFile db "C:/input.txt",0
outputFile db "C:/output.txt",0
divisor equ 10
;section .bss
buffer db 100 DUP(?)
resultado dw 1 DUP(?)
iresultado db 5 DUP(?)
sresultado db 5 DUP(?)
bsize equ $ -buffer



