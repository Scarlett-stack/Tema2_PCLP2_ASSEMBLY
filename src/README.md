<html>
<body>
<h1>TEMA 2 IOCLA 2023</H1>
<h3>Banu Daria 315 CC</h3>
<br>
<h4>Pentru o buna experienta readme apasa fisierul si alege Open Preview</h4>
<br><b><u>Task 1</u></b><br><br>
<p>In acest task, am pastrat ecx intact pentru ca am aplicat loop<br>

```
loop valid
```
Preiau un caracter din esi ii adaug step si verific daca e mai mare ca Z = 0x50<br>
Daca nu e mai mare sar direct la pus in esi (enc_string).
Altfel executa :

```
sub al,26
```
Si trec si la urm caractere din stringuri</p>
<br><br>
<b><u>Task 2</u></b><br>
<p>Dupa ce l-am facut nu mi s-a parut asa greu dar sincera sa fiu <br>
ma apucase plansul de la cate seg faulturi mi-am luat<br>
Ideea mea fost sa fac un selection sort, algoritmul meu preferat <s>si inefiecient</s>
<br>
Am luat 2 loop-uri : loop12 si loop 22. Loop 12 merge de la 0 la N-1.<br>
Loop22 merge de la i+1 pana la N.<br>

```
mov edi,ecx
add edi,5
```
Aici ma asigur ca edi e de la ecx + 5 unde 5 e offsetul dat de structura.<br>
In loop22 se intampla chestiile interesante. First, compar prioritatile de la i si i+1<br>
Daca prio i < prio i+1 trec la urmatorul din bucla 2 <u>(jl nu_swap)</u><br>
Daca prio i > prio i+1 nu mai compar si celelalte campuri si sar direct in swap.<br>
Daca sunt egale se merge mai departe si se face comp pe fieldul time.<br>
Si iar ma joc cu nu_swap si nu_cmp.

```
movzx ebx , byte [edx + ecx + 2]   
         movzx esi , byte [edx + edi + 2]  

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
        
```
In nu_cmp se face swap camp cu camp. <br><i>Mindblowing, right?</i>
Am avut nevoie de <b>al</b> asa ca am salvat <b>eax</b> pe stiva.<br>
<i>Let the code lines speak for themselves:</i><br>

```
        push eax                         
        mov ax, word [edx+ecx]              
        mov bx , word [edx+edi] 
        mov word [edx+ecx],bx
        mov word [edx+edi],ax

        xor eax,eax                         
        xor ebx, ebx                        

        mov al, byte [edx+ecx +2]     
        mov bl, byte [edx+edi +2]
        mov [edx+ecx +2],bl
        mov  [edx+edi +2],al

        xor eax,eax
        xor ebx, ebx

        mov ax, word[edx+ecx +3] 
        mov bx, word [edx+edi +3]
        mov  [edx+ecx+3],bx
        mov  [edx+edi+3],ax

        pop eax
```
In run_procs.asm am luat vectorul de structuri si l-am paracurs.<br>
Pentru fiecare tip de prioritate am cate un contor.<br>
Numar fieacre tip de prio si o pun in vectorul global corespunzator<br>
Pentru time iau in <b>edi</b> timpul din vectorul universal de la pozitia prioritatii<br>
si in <b>esi</b> pun timpul din vectorul primit ca argument<br>
Apoi adun registrele si rezulattul il mut in vectorul global pt timp<br>
Acum ca am cei doi vectori fac div. Loopez prin vectorii obtinuti at the same time.<br>
Iau fiecare elemnt am grija sa pastrez neaparat <b>eax</b>. Dar tot in eax am si<br>
pointerul la vector. Inseamna ca facem push la eax. <br>

```
loop_pt_avg:
        push eax    
```
Apoi respect cu strictete ce se face la div. IN eax pun pe divident.<br>
In ebx pun impartirotul. Mai intai evit floating point exception verficand<br>
ebx. Daca e 0 sar la nu_impart direct scot pointerul si pun la fieldurile pozitiei<br>
aferente 0. Daca nu e 0 nu face jump si face impartirea si dupa <br>
<i>alunecand usor pe-o raza</i> intra in nu_impart si pune ce gaseste in ebx la quo-cat<br>
si din edx (restul) in .remain (offsetul de 2).<br>
Overall nu a fost o problema grea. Singura dubiosenie a fost ecx <br>
A trebuit sa folosesc ebx ca sa imi dea punctajul.<br>
</p>
<br><br>
<u><b>Task 4</b></u>
<p> Foarte ok task-ul.Straightforward stuff. Mai intai am luat cele 4 margini<br>
Cazurile speciale: (0,0),(0,7),(7,0),(7,7). Fiind intoarse liniile,<br>
se calculeaza un pic altfel indicii: Astfel:<br>
-> <u>vecin stanga sus</u> A(i+1,j-1)<br>
-> <u>vecin stanga jos</u> A (i-1,j-1)<br>
-> <u>vecin dreapta sus</u> A(i+1,j+1)<br>
-> <u>vecin dreapta jos</u> A(i-1,j+1)<br>

</body>
</html>