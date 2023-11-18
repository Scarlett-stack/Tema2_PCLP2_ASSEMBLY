%include "../include/io.mac"
section .data

section .text
	global checkers
    extern printf

checkers:
    ;; DO NOT MODIFY
    push ebp
    mov ebp, esp
    pusha

    mov eax, [ebp + 8]	; x
    mov ebx, [ebp + 12]	; y
    mov ecx, [ebp + 16] ; table

    ;; DO NOT MODIFY
    ;; FREESTYLE STARTS HERE
  
    mov edx, 0
;pt aceasta problema am luat marginile matricei
;si le-am tratat separat
;in caz ca era pe interior nu intra in je-uri si se duce in jos
;o data ce s-a executat miscarea / miscarile se sare la over

    cmp eax,0 ; sunt pe linia 0
    je linia_0

    cmp eax, 7
    je linia_7

    cmp ebx, 0
    je coloana_0

    cmp ebx, 7
    je coloana_7

    push eax
    push ebx
    ; acum intra pe caz general
    ; calculam cele 4 pozitii aferente 
    ;pozitia i+1, j-1
    inc eax
    dec ebx
    imul eax,8
    add eax, ebx
    mov edx, 1
    mov [ecx + eax], edx

    ; pozitia i-1 j-1
    pop ebx
    pop eax
    push eax
    push ebx
    dec eax
    dec ebx
    imul eax,8
    add eax, ebx
    mov [ecx + eax], edx
  
    ; pozitia i+1 j+1
    pop ebx
    pop eax
    push eax
    ;push ebx
    inc ebx
    inc eax
    imul eax,8
    add eax, ebx
    mov [ecx + eax],edx

    ; i-1 j+1
    pop eax
    dec eax
    imul eax,8
    add eax, ebx
    mov [ecx + eax], edx
    jmp over


coloana_7:
        cmp eax,0       ; am doua cazuri delicate linia 0 si linia 7
        je linie_0_col_7

        cmp eax, 7
        je linia_7_col_7

        dec ebx
        push eax
        inc eax
        imul eax,8
        add eax, ebx
        mov edx,1
        mov [ecx + eax], edx
        pop eax
        dec eax
        imul eax,8
        add eax,ebx
        mov [ecx + eax], edx
        jmp over
coloana_0:
        cmp eax, 7
        je linia_7_col_0

        cmp eax, 0
        je linie_0_col_0

        inc ebx         ;j+1
        push eax
        inc eax         ; i+1
        imul eax,8      ; calculez offset
        add eax,ebx     ; calculez offset
        mov edx,1
        mov [ecx + eax],edx
        pop eax
        dec eax
        imul eax,8
        add eax, ebx
        mov [ecx + eax],edx
        jmp over
linia_0:
        cmp ebx,0
        je linie_0_col_0

        cmp ebx, 7
        je linie_0_col_7
        inc eax
        push eax
        push ebx
        dec ebx
        imul eax,8
        add eax,ebx
        ;mov edx, [ecx + eax]
        mov edx,1
        mov [ecx + eax],edx
        pop ebx
        pop eax         ; iau la loc eax
        inc ebx         ; j+1
        imul eax,8      ; calculez offsetul
        add eax, ebx    ; calculez offsetul
        mov edx,1       ; ca sa nu scriu dword
        mov [ecx + eax], edx
        jmp over         ; au revoir shoshanaa!
        jmp over
linie_0_col_0:
        inc eax
        inc ebx
        imul eax,8
        add eax,ebx
        mov edx,1
        mov  [ecx + eax],edx
        jmp over
linie_0_col_7:
        inc eax
        dec ebx
        imul eax,8
        add eax,ebx
        mov edx,1
        mov [ecx + eax],edx
        jmp over
linia_7:
        cmp ebx, 0
        je linia_7_col_0
        
         cmp ebx, 7
         je linia_7_col_7

         dec eax
         push eax
         push ebx
         dec ebx
         mov edx,1
         imul eax,8
         add eax, ebx
         mov [ecx + eax], edx

         pop ebx
         pop eax
         inc ebx
         imul eax, 8
         add eax, ebx
         mov edx,1
         mov [ecx + eax], edx
         jmp over 

linia_7_col_0:
         dec eax
         inc ebx
         imul eax,8
         add eax,ebx
         mov edx,1
         mov [ecx + eax], edx
         jmp over
linia_7_col_7:
         dec eax,
         dec ebx
         imul eax,8
         add eax,ebx
         mov edx,1
         mov [ecx + eax],edx
         jmp over 



    ;; FREESTYLE ENDS HERE
over:
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY