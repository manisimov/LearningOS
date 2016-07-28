#    .code16gcc
    .code16
    .section .data
    .globl hello
hello:
    .asciz "Hello, world"
numbers:
    .ascii "0123456789ABCDEF"
    
    .section .text
    .globl	_start
	.type	_start, @function
_start:
    #ljmp     $0x00, $0x7c00
    cli
    xor     %ax, %ax
    movw    %ax, %ds
    movw    %ax, %ss
    movw    %ax, %es
    movw    %ax, %bx
    #movw    %ax, %cs
    movw    $0x7c00, %sp
    #movl    $0x00, %ss
    sti

    movl    $0x00, %edi
loop2:
    movb    hello(,%edi,1), %al # load next symbol to AL, jump to the end if zero
    cmpb    $0x00, %al
    je      end
   
    call    putchar # print symbol on the terminal
    
    incl     %edi
    jmp     loop2
 
end:
    movb    $0x0D, %al
    call    putchar
    movb    $0x0A, %al
    call    putchar      # new line
    
    
    # print ax value
    movw    numbers, %ax    
    call    print_ax
    # print E at the end
    movb    $0x45, %al
    call    putchar
end_loop:
    jmp     end_loop    
    
    
    
    .type	putchar, @function
# Arguments:  %al - symbol to print
putchar:
    movw    $0x00, %bx
    movb    $0x0E, %ah # print symbol on the terminal
    int     $0x10
    ret
    
    
    .type   print_ax, @function
print_ax:
    push    %edi
    push    %bx
    push    %dx
    movb    $4, %ch
    movw    %ax, %dx   # input is in dx
    #movw    $0x000F, %bx 
print_ax_loop:
    #
    #
    decb    %ch
    
    movw    %dx, %ax
    movb    %ch, %cl   # ch shifts by byte
    salb    $2, %cl    # cl shifts by bit
    sarw    %cl, %ax
    andl    $0x0000000f, %eax
    movl    %eax, %edi
    movb    numbers(,%edi,1), %al
    call    putchar
    #mov
    
    #
    
    cmpb    $0x00, %ch
    jne     print_ax_loop     
    
    movb    $0x0D, %al
    call    putchar
    
    movb    $0x0A, %al
    call    putchar
    
    pop     %dx
    pop     %bx
    pop     %edi
    ret
    
    
    .type   print_ax, @function
print_4_bit_number:
    
