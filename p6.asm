.model small
.STACK 100H
.DATA
L DW 0
t dw 0 
stringstartadress db 0
MSG1 DB 13,10,'please enter a string of only lower-case letters:  $' 
MSG2 DB 13,10,'a. ENTER A NEW STRING $'  
MSG3 DB 13,10,'b. REVERSE THE STRING $'
MSG4 DB 13,10,'c. CHECK IF PALINDROME $'
MSG5 DB 13,10,'YOUR OPTION:  $' 
MSG6 DB 13,10,'the string is a palindrome!  $'
MSG7 DB 13,10,'the string is not a palindrome.  $' 
msg8 db 13,10,'enter any other character to end the string. $'
msg9 db 13,10,'your string: $'
msg10 db 13,10,'the reversed string is: $'

.CODE


proc deletelaststring:
clearstring:
   
mov bp, sp                
cmp [l], 0
jbe gst:           ;after it finish to delete the last string
pop ax
sub [l], 2
jmp clearstring
gst:
ret 
endp deletelaststring:

proc menuep: 
;gst:              ;getting the string



MENUE: 

LEA DX, MSG2  ;DISPLAY MSG2 
MOV AH, 09
INT 21H

LEA DX, MSG3  ;DISPLAY MSG3 
MOV AH, 09
int 21h 

LEA DX, MSG4  ;DISPLAY MSG4
int 21h

LEA DX, MSG5  ;DISPLAY MSG5
int 21h

MOV AH, 1   ;GET OPTION A-C                                         
INT 21H

 

CMP AL, 'a'
JE A
CMP AL, 'b'
JE B
CMP AL, 'c'
je c

jmp menue ;if there's no correct option it asks again 
B:
call reversing: 
         
jmp menue

c:
call palindromecheck:
jmp menue
A:
call getstring: 
jmp menue  

endp menuep          

proc getstring  ;acepting a new string
push bp    


LEA DX, MSG1  ;DISPLAY MSG1 
MOV AH, 09
INT 21H

LEA DX, MSG8  ;DISPLAY MSG8 

INT 21H 

LEA DX, MSG9  ;DISPLAY MSG9 

INT 21H 
call deletelaststring:      ;deleting the last string
 
mov cx, 20
gettingchar:
mov ah, 1
int 21h
mov ah, 0
cmp al, 61h
jb MENUE
cmp al, 7ah
ja MENUE
push ax
add [l], 2
loop gettingchar
pop bp 
ret 2
endp getstring           

proc reversing:     
    
mov cx, [l]
mov bp, sp

LEA DX, MSG10  ;DISPLAY MSG2 
MOV AH, 09
INT 21H
printing:
mov dx, [bp + 2]
mov ah, 2
int 21h
add bp, 2

dec cx
loop printing:
MOV BP, SP
MOV CX, [L]
mov si, bp
add si, cx
sub si, 2
mov [t], 0
REVERSE:
add [t], 2
mov ax, [bp + 2]
mov bx, bp
mov bp, si
mov dx, [bp + 2]

mov [bp + 2], ax
mov bp, bx
mov [bp + 2], dx
mov bx, [t]
add bx, [t]
cmp bx, [l]
jae afterreverse
sub si, 2
add bp, 2

afterreverse:
dec cx
loop REVERSE 

ret 
endp reversing:         

proc palindromecheck:     

MOV BP, SP
MOV CX, [L]

mov si, bp
add si, cx


palindrome:

mov ax, [bp + 2]     ;first letter
mov bx, bp
mov bp, si
mov dx, [bp]     ;last letter
mov bp, bx

cmp ax, dx
jne false


sub si, 2
add bp, 2
dec cx
loop palindrome

true:
mov ah, 9
LEA DX, MSG6  ;DISPLAY MSG6
int 21h
jmp palindromeend

false: 
mov ah, 9
LEA DX, MSG7  ;DISPLAY MSG7
int 21h
jmp palindromeend

palindromeend:
ret 
endp palindromecheck:    
    




START:
MOV AX, @DATA
MOV DS, AX 
call getstring:

END START                              