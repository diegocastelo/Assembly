%include "io64.inc"

section .data
    cpf db 0, 7, 8, 3, 4, 4, 9, 2, 3, 2, 2;Declaracao do cpf
    TAMANHO_DO_ARRAY equ 11
    
section .text        
global CMAIN
CMAIN:
    mov rbp, rsp; for correct debugging

    mov r12, 1 ;se r12 continuar 1 = CPF valido, se nao cpf invalido
    
   
    mov rbp, rsp; for correct debugging
    
    
    
    xor rax, rax
    xor rbx, rbx
    xor rcx, rcx
    xor rdx, rdx
    xor cx, cx
    xor ecx, ecx
    
    
    
    mov rdx, 10 ;parte da somatoria que vai ser decrementada
    mov rsi, 0
    
    mov r14b, byte [cpf + 9]; registrando o primeiro digito verificador no r14
    mov r15b, byte [cpf + 10]; registrando o segundo digito verificador no r15
    
    xor rcx, rcx
    
    soma1: ;loop para a primeira soma
    mov rax, 0 
    mov rax, rdx
    mul byte [cpf + rsi]
    add rbx, rax
    dec rdx
    inc rsi
    cmp rdx, 1 ;quando o rdx for decrementado ate 1 o loop chegara ao fim
    jg soma1
    
    xor rdx, rdx ;limpando o rdx para podermos usar para o resto da divisao abaixo
    
    mov rax, rbx
    
    mov cx, 10
    mul cx       ;multiplicando o cx com o rax
    mov ecx, 11  ;valor de rax agora eh o resultado da multiplicacao
    div ecx      ;dividindo o rax por ecx
    
    cmp rdx, r14 ;comparando o resto da divisao com o primeiro verificador
    jne invalido ;caso for diferente pula para o label invalido 
    
    xor rdx, rdx ;limpando os registradores que serao usados
    xor rbx, rbx
    xor rax, rax
    xor rcx, rcx
    
    mov rdx, 11 ;reatribuindo o valor de rdx para a proxima somatoria
    mov rsi, 0
    
    soma2: ;loop para a segunda soma
    mov rax, rdx
    mul byte [cpf + rsi]
    add rbx, rax
    dec rdx
    inc rsi
    cmp rdx, 1  ;quando o rdx for decrementado ate 1 o loop chegara ao fim
    jg soma2
    
    xor cx, cx  ;limpando o cx para realizar a multiplicacao
    xor ecx, ecx;limpando o ecx para realizar a divisao
    
    xor rdx, rdx
    
    mov rax, rbx
    
    ;multiplicando o cx com o rax
      ;valor de rax agora eh o resultado da multiplicacao
      ;dividindo o rax por ecx
    
    
    mov cx, 10
    mul cx      ;multiplicando o cx com o rax
    mov ecx, 11 ;valor de rax agora eh o resultado da multiplicacao
    div ecx     ;dividindo o rax por ecx
    
    cmp rdx, r15;comparando o resto da divisao com o primeiro verificador
    je valido   ;caso for igual ira pular para o label valido
    
    invalido:
    
    mov r12, 0  ;trocara o valor de r12 para zero o que indica que o cpf eh invalido
    
    valido:
    
 ret