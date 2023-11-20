; .model small
; .stack 100h

; .data
;     msg db 'what is the date$'
;     year db 0
;     month db 0
;     day db 0

; .code
;     main proc
;         mov ax, @data
;         mov ds, ax

;         ; 初始化段寄存器
;         mov ax, 0B800h
;         mov es, ax

;         ; 初始化堆栈
;         mov ax, 0
;         mov ss, ax
;         mov sp, 100h

;         ; 显示提示信息
;         mov ah, 09h
;         mov dx, offset msg
;         int 21h

;         ; 输出响铃字符
;         mov ah, 07h
;         mov al, 07h
;         int 10h

;         ; 调用GetNum接收年月日值
;         call GetNum
;         mov year, al

;         call GetNum
;         mov ah, 0
;         mov al, year
;         mov bl, 10
;         mul bl
;         add al, ah
;         mov year, al

;         call GetNum
;         mov ah, 0
;         mov al, year
;         mov bl, 10
;         mul bl
;         add al, ah
;         mov year, al

;         call GetNum
;         mov ah, 0
;         mov al, year
;         mov bl, 10
;         mul bl
;         add al, ah
;         mov year, al

;         call GetNum
;         mov month, al

;         call GetNum
;         mov ah, 0
;         mov al, month
;         mov bl, 10
;         mul bl
;         add al, ah
;         mov month, al

;         call GetNum
;         mov day, al

;         call GetNum
;         mov ah, 0
;         mov al, day
;         mov bl, 10
;         mul bl
;         add al, ah
;         mov day, al

;         ; 调用Disp显示年值
;         mov dl, year
;         call Disp

;         ; 输出字符 '-'
;         mov ah, 02h
;         mov dl, '-'
;         int 21h

;         ; 调用Disp显示月值
;         mov dl, month
;         call Disp

;         ; 输出字符 '-'
;         mov ah, 02h
;         mov dl, '-'
;         int 21h

;         ; 调用Disp显示日值
;         mov dl, day
;         call Disp

;         ; 结束程序
;         mov ah, 4Ch
;         int 21h
;     main endp

;     ; 接收键入的数字
;     GetNum proc
;         mov ah, 01h
;         int 21h
;         sub al, 30h
;         ret
;     GetNum endp

;     ; 显示数字
;     Disp proc
;         add dl, 30h
;         mov ah, 02h
;         int 21h
;         ret
;     Disp endp

; end main


.MODEL SMALL
.STACK 100H

.DATA
    MSG DB 'WHAT IS THE DATE$' ; 提示信息
    YEAR DB 0 ; 年份
    MONTH DB 0 ; 月份
    DAY DB 0 ; 日期

.CODE
    MAIN PROC
        MOV AX, @DATA
        MOV DS, AX ; 将数据段地址存入DS寄存器

        ; 初始化段寄存器
        MOV AX, 0B800H
        MOV ES, AX ; 将显存段地址存入ES寄存器

        ; 初始化堆栈
        MOV AX, 0
        MOV SS, AX
        MOV SP, 100H ; 设置堆栈段地址和堆栈指针

        ; 显示提示信息
        MOV AH, 09H
        MOV DX, OFFSET MSG
        INT 21H ; 调用21H中断显示提示信息

        ; 输出响铃字符
        MOV AH, 07H
        MOV AL, 07H
        INT 10H ; 调用10H中断输出响铃字符

        ; 调用GETNUM接收年月日值
        CALL GETNUM ; 调用GETNUM过程获取年份的个位数
        MOV YEAR, AL ; 将获取的个位数存入YEAR变量

        CALL GETNUM ; 调用GETNUM过程获取年份的十位数
        MOV AH, 0
        MOV AL, YEAR
        MOV BL, 10
        MUL BL ; 将个位数乘以10
        ADD AL, AH ; 加上十位数
        MOV YEAR, AL ; 将结果存入YEAR变量

        CALL GETNUM ; 调用GETNUM过程获取年份的百位数
        MOV AH, 0
        MOV AL, YEAR
        MOV BL, 10
        MUL BL ; 将十位数乘以10
        ADD AL, AH ; 加上百位数
        MOV YEAR, AL ; 将结果存入YEAR变量

        CALL GETNUM ; 调用GETNUM过程获取年份的千位数
        MOV AH, 0
        MOV AL, YEAR
        MOV BL, 10
        MUL BL ; 将百位数乘以10
        ADD AL, AH ; 加上千位数
        MOV YEAR, AL ; 将结果存入YEAR变量

        CALL GETNUM ; 调用GETNUM过程获取月份的个位数
        MOV MONTH, AL ; 将获取的个位数存入MONTH变量

        CALL GETNUM ; 调用GETNUM过程获取月份的十位数
        MOV AH, 0
        MOV AL, MONTH
        MOV BL, 10
        MUL BL ; 将个位数乘以10
        ADD AL, AH ; 加上十位数
        MOV MONTH, AL ; 将结果存入MONTH变量

        CALL GETNUM ; 调用GETNUM过程获取日期的个位数
        MOV DAY, AL ; 将获取的个位数存入DAY变量

        CALL GETNUM ; 调用GETNUM过程获取日期的十位数
        MOV AH, 0
        MOV AL, DAY
        MOV BL, 10
        MUL BL ; 将个位数乘以10
        ADD AL, AH ; 加上十位数
        MOV DAY, AL ; 将结果存入DAY变量

        ; 调用DISP显示年值
        MOV DL, YEAR
        CALL DISP ; 调用DISP过程显示年份

        ; 输出字符 '-'
        MOV AH, 02H
        MOV DL, '-'
        INT 21H ; 调用21H中断输出字符

        ; 调用DISP显示月值
        MOV DL, MONTH
        CALL DISP ; 调用DISP过程显示月份

        ; 输出字符 '-'
        MOV AH, 02H
        MOV DL, '-'
        INT 21H ; 调用21H中断输出字符

        ; 调用DISP显示日值
        MOV DL, DAY
        CALL DISP ; 调用DISP过程显示日期

        ; 结束程序
        MOV AH, 4CH
        INT 21H ; 调用21H中断结束程序
    MAIN ENDP

    ; 接收键入的数字
    GETNUM PROC
        MOV AH, 01H
        INT 21H ; 调用21H中断接收键入的字符
        SUB AL, 30H ; 将字符转换为数字
        RET ; 返回获取的数字
    GETNUM ENDP

    ; 显示数字
    DISP PROC
        ADD DL, 30H ; 将数字转换为字符
        MOV AH, 02H
        INT 21H ; 调用21H中断显示字符
        RET ; 返回
    DISP ENDP

END MAIN 



