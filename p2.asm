.model small
.STACK 100H
.DATA
L DW 0
MSG1 DB 13,10,'PLEASE ENTER A STRING ENTER CAPITAL LETTER OR A CHARACTER THAT ISN"T A LETTER TO FINISH THE WORD:  $' 
MSG2 DB 13,10,'a. ENTER A NEW STRING $'  
MSG3 DB 13,10,'b. REVERSE THE STRING $'
MSG4 DB 13,10,'c. CHECK IF PALINDROME $'
MSG5 DB 13,10,'YOUR OPTION:  $' 
MSG6 DB 13,10,'true:  $'
MSG7 DB 13,10,'false:  $'


.CODE

START:
MOV AX, @DATA
MOV DS, AX 

A:                ;accepting a new string
mov bp, sp                
cmp [l], 0
jbe gst           ;to delete the last string
pop ax
sub [l], 2
jmp A
gst:              ;getting the string
;mov bp, sp 
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
MOV BP, SP
MOV CX, [L]

REVERSE:



mov dx, [bp]
mov ah, 2
int 21h
add bp, 2








dec cx
LOOP REVERSE
JMP MENUE
c:
mov bp, sp
mov cx, [l] 

palindrome:

mov bx, bp
add bx, cx
sub bx, 2       
mov ax, [bx]
cmp [bp], ax
jne false 
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