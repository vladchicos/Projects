%include "includes/io.inc"
extern getAST
extern freeAST

section .bss
root: resd 1
addr_nod_curent: resd 1
valoare_curenta: resd 1
flag: resd 1 ; switch pentru parcurgerea la dreapta sau stanga
sdop: resb 1 ; "stanga-dreapta operatie"
mins : resb 1 ; "switch pentru inmultirea cu -1"
section .text
global CMAIN


section .text
global main
main:
    mov ebp, esp; for correct debugging
    push ebp
    mov ebp,esp
    call getAST
    mov [root],eax
    mov [addr_nod_curent],eax
    
    mov dword [valoare_curenta],0
    call parcurg_arbore
    PRINT_DEC 4,[valoare_curenta] ;printez valoarea finala
    
    push dword[root]
    call freeAST
    xor eax, eax
    leave
    ret


parcurg_arbore:
    push ebp ;parcurg partea stanga
    mov ebp,esp
    call val_stg ;valoare element din nod stang
    
    mov byte [sdop],0
    xor ebx,ebx
    mov bl,byte[edx]
    cmp bl,'-'  
    je verific_val_negativa
    xor ebx,ebx
   
    mov bl,byte[edx]
    cmp bl,'/'
     
    jg continua_stg ; [edx] nu e operator ci valoare, nu trec la nodul urmator
    apel_nod_urmator_stg:
    mov dword [flag],4
    call apel_nod_urmator
   
    jmp gata
    continua_stg:
    mov eax,edx
    xor ecx,ecx
    mov byte[mins],0
    jmp converteste_in_nr
    am_convertit_nr:
    gata:
    push dword[valoare_curenta] 
    
    call val_drp ;parcurg partea dreapta
    mov byte [sdop],1
    xor ebx,ebx
    mov bl,byte[edx]
    cmp bl,'-' 
    
    je verific_val_negativa ;daca stringul incepe cu - verific daca este numar sau operator
    xor ebx,ebx
   
    mov bl,byte[edx]
    cmp bl,'/'  ;altfel verific daca este operator sau incepe cu numar
    
    jle apel_nod_urmator_drp
    jg continua_stg_drp ;[edx] nu e operator ci valoare, nu trec la nodul urmator
   

    apel_nod_urmator_drp:
    mov dword [flag],8
    push dword [valoare_curenta]
    call apel_nod_urmator
    jmp gata2 
   
    continua_stg_drp:
    mov byte[mins],0
    mov eax,edx
    xor ecx,ecx
    jmp converteste_in_nr
    am_convertit_nr2:
    gata2:
   
    jmp operatie
    operatie_finish:
    leave
    ret    

apel_nod_urmator:
    push ebp  ; inceputul nodului devine adresa operatorului curent
    mov ebp,esp
    push dword [addr_nod_curent]
    mov ecx,[addr_nod_curent]
    add ecx,[flag];
    mov ecx,[ecx]
    mov [addr_nod_curent],ecx

    call parcurg_arbore
    pop ebx
    mov [addr_nod_curent],ebx
    leave
    ret
    
    
val_stg: ;adresa nodului stang
    push ebp
    mov ebp,esp
        
    mov edx, [addr_nod_curent]
    add edx,4
    mov edx,[edx]
    mov edx,[edx]
    leave
    ret
val_drp: ; addresa nodului drept
    push ebp
    mov ebp,esp
    mov edx, [addr_nod_curent]
    add edx,8
    ;use lea
    mov edx,[edx]
    mov edx,[edx]
    leave
    ret
    
operatie:
    pop ebx ; preiau valoare_curenta din stack
    calculeaza:
    mov eax,[addr_nod_curent] ;cauta operatorul de la nodul curent
    mov eax,[eax]
    mov eax,[eax]
    cmp eax,'-'
    jl adunare_sau_inmultire
    je scadere
    jg impartire
    
    adunare_sau_inmultire:
    cmp eax,'+'
    je adunare
    jl inmultire

adunare:
    add ebx,[valoare_curenta]
    mov [valoare_curenta],ebx
    jmp operatie_finish
inmultire:
    imul ebx,[valoare_curenta]
    mov [valoare_curenta],ebx
    jmp operatie_finish
scadere:
    sub ebx,[valoare_curenta]
    mov [valoare_curenta],ebx
    jmp operatie_finish
impartire:
    mov eax,ebx
    mov ebx,[valoare_curenta]
    push edx
    cdq
    idiv ebx
    
    mov [valoare_curenta],eax
    pop edx
    jmp operatie_finish        

verific_val_negativa:
    mov eax,edx
    xor edx,edx 
    mov ecx,0
    cmp byte [eax+1],0
    je am_atins_null
    jg incrementez_prima_pozitie
    leave
    ret

am_atins_null:
    cmp byte [sdop],0 ;sdop functioneaza ca un switch
    je apel_nod_urmator_stg
    jg apel_nod_urmator_drp
    leave
    ret
incrementez_prima_pozitie:
    inc eax
    mov byte[mins],1
converteste_in_nr:
    cmp byte [eax+ecx],0
    jg incrementez_counter
    mov ebx,1
    je goleste_val
    leave
    ret
incrementez_counter:
    inc ecx ;ecx este counterul
    jmp converteste_in_nr

goleste_val:
    mov dword [valoare_curenta],0

string_in_int:  ;parcurg fiecare byte din string, convertesc in int si inmultesc cu 10^index
    xor edx,edx 
    mov dl, byte [eax+ecx-1]
    sub dl,'0'
    imul edx ,ebx
    imul ebx,10
    add [valoare_curenta],edx
    dec ecx
    cmp ecx,0
    jg string_in_int
    jmp verific_flag_mins
verific_flag_mins:
    cmp byte[mins],0 ;[mins] functioneaza ca un switch, 0->val pozitiva 1->val negativa
    je go_on ;valoare pozitiva
    jg pozitiv_in_negativ 
pozitiv_in_negativ:
    mov ecx,[valoare_curenta]
    imul ecx,-1
    mov [valoare_curenta],ecx
go_on:
    cmp byte[sdop],0
    je am_convertit_nr
    jg am_convertit_nr2
    
        
