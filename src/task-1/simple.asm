%include "../include/io.mac"

section .text
    global simple
    extern printf

simple:
    ;; DO NOT MODIFY
    push    ebp
    mov     ebp, esp
    pusha

    mov     ecx, [ebp + 8]  ; len
    mov     esi, [ebp + 12] ; plain
    mov     edi, [ebp + 16] ; enc_string
    mov     edx, [ebp + 20] ; step

    ;; DO NOT MODIFY
   
    ;; Your code starts here
     
valid:
    mov al, byte [esi]                      ; iau un octet adica un char 
    add al, dl                              ;adaug step 
    cmp al, 0x5A                            ;verifc daca depaseste alfabetul
    jle nu_scurtez                          ; if not il las asa
    sub al, 26                              ; scad si pleaca jos
nu_scurtez:
     mov byte [edi], al                     ; scriu in enc_string
     inc esi                                ; next ch
     inc edi                                ; pregatesc offsetul urm in edi
     loop valid

    ;; Your code ends here
    
    ;; DO NOT MODIFY


    popa
    leave
    ret
    
    ;; DO NOT MODIFY
