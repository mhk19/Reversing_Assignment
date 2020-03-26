section .data
    inputByteMsg db "Enter the bytes to be converted:\n"
    lenInputByteMsg equ $-inputByteMsg
    keyValueMsg db "Enter the key value:\n"
    lenKeyValueMsg equ $-keyValueMsg
    outputMessage db "Xored value is:\n"
    lenOutputMessage equ $-outputMessage

section .bss
    inputByte resb 100
    keyValue resb 1
    count resb 1

section .text
    GLOBAL _start

_start:
    mov eax, 4                      ;display input message for inputByte
    mov ebx, 1
    mov ecx, inputByteMsg
    mov edx, lenInputByteMsg
    int 0x80

    mov eax, 3                       ;take input of inputByte
    mov ebx, 2
    mov ecx, inputByte  
    mov edx, 100
    int 0x80

    mov [count],al                  ;store the location of last byte of the inputByte in count to further use it as counter of loop

    mov eax, 4
    mov ebx, 1                      ;display input message for keyValue
    mov ecx, keyValueMsg
    mov edx, lenKeyValueMsg
    int 0x80

    mov eax, 3
    mov ebx, 2                      ;take input of key value
    mov ecx, keyValue
    mov edx, 1
    int 0x80

    call single_byte_xor            ;call the function which will take xor

    mov eax,4
    mov ebx,1
    mov ecx, outputMessage          ;display output message
    mov edx, lenOutputMessage
    int 0x80

    mov eax,4
    mov ebx,1                       ;display output
    mov ecx, inputByte
    mov edx, 100
    int 0x80

    mov eax,1
    mov ebx,0                       ;exit
    int 0x80

single_byte_xor:
    mov ecx,[count]                 ;moving counter value to ecx
    mov eax, inputByte               
    mov bl, [keyValue]

    loop:
        xor byte[eax],bl            ;take xor
        add eax,1                   ;increase the memory location pointer
        loop loop
    ret