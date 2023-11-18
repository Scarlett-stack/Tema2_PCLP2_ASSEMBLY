%include "../include/io.mac"

struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc
section .text
    global sort_procs
    extern printf

SORTED EQU 0
UNSORTED EQU 1
sort_procs:
    ;; DO NOT MODIFY
    enter 0,0
    pusha

    mov edx, [ebp + 8]      ; processes
    mov eax, [ebp + 12]     ; length
    ;; DO NOT MODIFY

    ;; Your code starts here
    
    
    mov ecx,0
    sub eax,1
    lea eax, [eax*5-5]                      ; pt a nu da seg fault
    add eax, 5
    mov edi, 1

loop12:                            
    mov edi,ecx                             ; aci merg de la 0 la eax-1
    add edi,5

    loop22:
         movzx ebx , byte [edx + ecx + 2]   ;mut campurile de la poz i si i+1 
         movzx esi , byte [edx + edi + 2]   ;ca sa le compar

         ;urmeaza un nested if in care verific cerintele --prio egale? 
         ;-ma  uit la timp--egal si asta?-ma uit la pid

         cmp ebx, esi                       ; compar prio
         jl nu_swap                         ;  i < i+1 = da, merg mai departe

         cmp ebx, esi                       ; adica am trecut de jl =e mai mare
         jg nu_cmp                          ;fac swap

         movzx ebx , word [edx + ecx + 3]   ; iau time de la i
         movzx esi , word [edx + edi + 3]   ; si de la i+1

         cmp ebx,esi
         jl nu_swap

        movzx ebx , word [edx + ecx + 3]    ;redundant
        movzx esi , word [edx + edi + 3]

        cmp ebx,esi
        jg nu_cmp

        movzx ebx , word [edx + ecx]
        movzx esi , word [edx + edi]

        cmp ebx,esi
        jl nu_swap                          ;altfel intru jos
        

        ;-------ignora acest bloc----------
        ;lea ebx , [ecx*5] ;prepar vectorul pe i 12
        ;add ebx, edx
        ;lea esi , [edi*5] ; si elementul j 22
        ;add esi, edx
        ;------ignora acest bloc-------

nu_cmp:
        push eax                            ;salvez eax pt ca voi folosi de ax
        mov ax, word [edx+ecx]              ; fac swap pe pid
        mov bx , word [edx+edi] 
        mov word [edx+ecx],bx
        mov word [edx+edi],ax

        xor eax,eax                         ; curat eax
        xor ebx, ebx                        ; curat ebx

        mov al, byte [edx+ecx +2]           ; swap pe prio
        mov bl, byte [edx+edi +2]
        mov [edx+ecx +2],bl
        mov  [edx+edi +2],al

        xor eax,eax
        xor ebx, ebx

        mov ax, word[edx+ecx +3]            ; swap pe time
        mov bx, word [edx+edi +3]
        mov  [edx+ecx+3],bx
        mov  [edx+edi+3],ax

        pop eax

nu_swap:
        add edi,5                           ;increment cu sizeul structurii
        cmp edi,eax 
        jle loop22                          ;reiau a doua bucla
    
    add ecx, 5                              ; increment cu sizeul structrurii
    cmp ecx, eax                            ;reiau prima bucla
    jl loop12
    ;; Your code ends here
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY