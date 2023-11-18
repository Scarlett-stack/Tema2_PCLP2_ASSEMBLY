%include "../include/io.mac"

    ;;
    ;;   TODO: Declare 'avg' struct to match its C counterpart
    ;;
struc avg
    .quo: resw 1
    .remain: resw 1
endstruc
struc proc
    .pid: resw 1
    .prio: resb 1
    .time: resw 1
endstruc

    ;; Hint: you can use these global arrays
section .data
    prio_result dd 0, 0, 0, 0, 0
    time_result dd 0, 0, 0, 0, 0

section .text
    global run_procs
    extern printf

run_procs:
    ;; DO NOT MODIFY

    push ebp
    mov ebp, esp
    pusha

    xor ecx, ecx

clean_results:
    mov dword [time_result + 4 * ecx], dword 0
    mov dword [prio_result + 4 * ecx],  0

    inc ecx
    cmp ecx, 5
    jne clean_results

    mov ecx, [ebp + 8]      ; processes
    mov ebx, [ebp + 12]     ; length
    mov eax, [ebp + 16]     ; proc_avg
    ;; DO NOT MODIFY
   
    ;; Your code starts here
        ;cateva explicatii:
        ;iau doua loopuri mari pt fiecare vector global
        ;acolo le calculez numarul de prioritati, si suma timpului
        ;apoi loop prin vectorul avg din eax il completez cu rezultatul lui div
        ;!!! salvez pe stiva pointerul la vectorul avg !!!

        sub ebx,1
        lea ebx, [ebx*5-5]                  ; pt a nu da seg fault
        add ebx, 5

        xor edx, edx
        xor edi,edi

loop_count_prio:

        push edx
        movzx edx, byte [ecx + edx +2]      ;nu uita sa faci zx
                        
        cmp edx,1                           ;verific fiecare caz de prioritate
        je contor_1

        cmp edx,2
        je contor_2

        cmp edx,3
        je contor_3

        cmp edx,4
        je contor_4

        cmp edx,5
        je contor_5
contor_1:
        mov edi, dword[prio_result]         ; iau contorul vechi
        inc edi                             ; cresc contortul vechi
        mov dword [prio_result], edi
        jmp salt_universal
contor_2:
        mov edi, dword[prio_result + 4]     ;ma folosesc de offsets limitate 
        inc edi                             ;nu trb registru aditional
        mov dword [prio_result + 4],edi
        jmp salt_universal
contor_3:
        mov edi, dword [prio_result + 8]    ;same thing
        inc edi
        mov dword [prio_result +8], edi
        jmp salt_universal
contor_4:
        mov edi, dword [prio_result + 12]
        inc edi
        mov dword [prio_result +12], edi
        jmp salt_universal
contor_5:
        mov edi, dword [prio_result + 16]
        inc edi
        mov dword [prio_result +16], edi
        jmp salt_universal

salt_universal:
        ;mov edi, [prio_result + 12]
        ;PRINTF32 `%d****\n\0x`,edi
        pop edx                            ;scot din edx indx 
        add edx,5                          ;offsetul e 5 vezi struct size
        cmp edx,ebx
        jle loop_count_prio

        xor edi,edi                         ;prepar registrele
        xor edx,edx
        xor esi,esi

loop_count_time_for_prio:
        push edx

        ;movzx edx, word [ecx + edx + 3]
        ;PRINTF32 `timp din loop1: %d\n\0x`,edx
        movzx edx, byte [ecx + edx + 2]     ; aflu prioritatea ca sa calc. timpul

        cmp edx,1
        je contor_timp_1

        cmp edx,2
        je contor_timp_2

        cmp edx,3
        je contor_timp_3

        cmp edx,4
        je contor_timp_4

        cmp edx,5
        je contor_timp_5

contor_timp_1:
             pop edx
             mov esi, dword[time_result]
             movzx edi, word [ecx + edx + 3]

             add edi, esi                   ; adun timpi prio 1

             mov dword [time_result], edi
             mov edi, dword [time_result]

             push edx
             jmp salt_universal_2           ; plec mai departe la i+1

contor_timp_2:
             pop edx
             mov esi, dword[time_result + 4]
             movzx edi, word [ecx + edx + 3]

             add edi, esi                   ; adun timpi prio 2
             mov dword [time_result + 4], edi

             push edx
             jmp salt_universal_2

contor_timp_3:
             pop edx
             mov edi, dword[time_result + 8]
             movzx esi, word [ecx + edx + 3]

             add edi, esi                   ; adun timpi prio 3
             mov dword [time_result + 8], edi

             push edx
             jmp salt_universal_2 

contor_timp_4:
            pop edx
            mov edi, dword[time_result + 12]
            movzx esi, word [ecx + edx + 3]

            add edi, esi                    ; adun timpi prio 4
            mov dword [time_result + 12], edi

            push edx
            jmp salt_universal_2

contor_timp_5:
            pop edx
            mov edi, dword[time_result + 16]
            movzx esi, word [ecx + edx + 3]

            add edi, esi                    ; adun timpi prio 5
            mov dword [time_result + 16], edi

            push edx
            jmp salt_universal_2
                           
salt_universal_2:                           ;indiferent ce se alege tot loop
        mov edi, dword [time_result + 16]
        pop edx
        add edx,5
        cmp edx,ebx
        jle loop_count_time_for_prio

  xor edi, edi                              ;pregatesc registrele
  xor ecx, ecx
  xor edx, edx

;aici sa comportat foarte ciudat cand foloseam ecx imi dadeau refurile la fel dar nici un punct
loop_pt_avg:
        push eax                            ; salvez vectorul
        mov eax, dword[time_result + ecx]   ; iau din vectorii corespunztaori
        mov ebx, dword[prio_result + ecx]   ; pt fiecare tip de prio
        xor edx, edx                        ;important sa curat AICI edx 
        cmp ebx,0                           ; evit floating point exception
        je nu_impart
    
        div ebx ; daca nu e 0 oricum intra aici
        mov ebx, eax;salvez catul
           
nu_impart:
        pop eax                             ;iau vectorul din nou 
        mov  word [eax+ecx], bx             ; acum pun in fiecare
        mov word [eax+ecx + 2], dx

        ;mov word [eax + edi],word ecx--astea dau seg fault 
        ;mov word [eax + edi + 2], word esi--ignora mizeriile astea

        add ecx,4                       ;cresc ecx cu 4 pt ca atat e structura      
        cmp ecx,20
        jl loop_pt_avg                  ;lower strcict ca plec de la 0

    ;; Your code ends here
    
    ;; DO NOT MODIFY
    popa
    leave
    ret
    ;; DO NOT MODIFY