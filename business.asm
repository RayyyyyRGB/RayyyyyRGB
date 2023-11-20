assume cs:codesg

data segment
    db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
    db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
    db '1993', '1994', '1995'
    ;长度为84的数组，一个字符一个字节：4X21

    dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
    dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

    dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
    dw 11542, 14430, 15257, 17800
data ends

;ax+210/16向上取整，即ax+14h
;对于ds，偏移量为16*14=224
table segment
    db 21 dup('year summ ne ?? ')
table ends

stack segment
    dw 1 dup(0)
stack ends

codesg segment
start:  mov ax, data
        mov ds, ax 
        mov bx, table
        mov es, bx  
        mov bx, 0   ;定位结构体数组元素
        mov di, 0   ;定位data中的4字节数据
        mov si, 0   ;定位data中的2字节数据
        mov cx, 15h
    s:  ;转移年份
        mov ax, ds:[di];
        mov es:[bx], ax
        mov ax, ds:[di+2]
        mov es:[bx+2], ax
        ;添加空格 
        mov byte ptr es:[bx+4], 32

        ;转移收入
        ;作为被除数
        mov ax, ds:[di+84];
        mov es:[bx+5], ax
        mov ax, ds:[di+86]
        mov es:[bx+7], ax
        ;添加空格 
        mov byte ptr es:[bx+9], 32

        ;转移雇员数量
        mov ax, ds:[si+168]
        mov es:[bx+10], ax
        ;添加空格 
        mov byte ptr es:[bx+12], 32

        ;计算人均收入，并转移到table中
        mov ax, es:[bx+5]   ;低16位
        mov dx, es:[bx+7]   ;高16位
        div word ptr es:[bx+10]
        mov es:[bx+13], ax  ;商默认存放在ax中 
        ;添加空格 
        mov byte ptr es:[bx+15], 32 

        ;操作完成，bx加16，di加2
        add bx, 16  
        add di, 4
        add si, 2
        loop s

        mov ax, 4c00h
        int 21h

        print_data proc
            mov ax, 4c00h
            int 21h
            ret
        print_data endp


codesg ends
end start