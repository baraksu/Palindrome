.model small
.STACK 100H
.DATA
L DW 0
t dw 0
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

START:
MOV AX, @DATA
MOV DS, AX 

A:                ;accepting a new string


LEA DX, MSG1  ;DISPLAY MSG1 
MOV AH, 09
INT 21H

LEA DX, MSG8  ;DISPLAY MSG8 

INT 21H 

LEA DX, MSG9  ;DISPLAY MSG9 

INT 21H
clearing:

mov bp, sp                
cmp [l], 0
jbe gst           ;to delete the last string
pop ax
sub [l], 2
jmp clearing
gst:              ;getting the string

mov cx, 20
gch:
mov ah, 1
int 21h
mov ah, 0
cmp al, 61h
jb MENUE
cmp al, 7ah
ja MENUE
push ax
add [l], 2
loop gch

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

           


B:          
mov cx, [l]
mov bp, sp

LEA DX, MSG10  ;DISPLAY MSG2 
MOV AH, 09
INT 21H
p:
mov dx, [bp]
mov ah, 2
int 21h
add bp, 2

dec cx
loop p:
MOV BP, SP
MOV CX, [L]
mov si, bp
add si, cx
sub si, 2
mov [t], 0
REVERSE:
add [t], 2
mov ax, [bp]
mov bx, bp
mov bp, si
mov dx, [bp]



mov [bp], ax
mov bp, bx
mov [bp], dx
mov bx, [t]
add bx, [t]
cmp bx, [l]
jae MENUE
sub si, 2
add bp, 2




dec cx
loop REVERSE   

JMP MENUE
c:
 
MOV BP, SP
MOV CX, [L]

mov si, bp
add si, cx
sub si, 2

palindrome:

mov ax, [bp]     ;first
mov bx, bp
mov bp, si
mov dx, [bp]     ;last
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
jmp MENUE

false: 
mov ah, 9
LEA DX, MSG7  ;DISPLAY MSG7
int 21h
jmp MENUE

END START                              