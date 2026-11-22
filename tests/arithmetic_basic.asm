
# Prueba propia 01
# Cobertura:
# add: operandos positivos y un operando negativo
# sub: operandos positivos y un operando negativo
# addi: inmediato negativo
# addu: mediante move
# addiu: mediante li
# slt: comparacion con negativo, resultado 1
# $zero: intento de escritura

.text
.globl main

main:
    li $v0, 11

    li $t0, 7
    li $t1, 2

    # 7 + 2 = 9
    add $t2, $t0, $t1
    addi $a0, $t2, 48
    syscall

    # 7 - 2 = 5
    sub $t2, $t0, $t1
    addi $a0, $t2, 48
    syscall

    # 7 + (-3) = 4
    addi $t2, $t0, -3
    addi $a0, $t2, 48
    syscall

    # move utiliza addu
    move $t3, $t2
    addi $a0, $t3, 48
    syscall

    # li con valor pequeno utiliza addiu
    li $t4, 2
    addi $a0, $t4, 48
    syscall

    # 2 - 7 = -5, luego 7 + (-5) = 2
    sub $t5, $t1, $t0
    add $t6, $t0, $t5
    addi $a0, $t6, 48
    syscall

    # -5 - 2 = -7; -7 < 0 produce 1
    sub $t7, $t5, $t1
    slt $s0, $t7, $zero
    addi $a0, $s0, 48
    syscall

    # $zero debe permanecer igual a cero
    addi $zero, $zero, 9
    addi $a0, $zero, 48
    syscall

    # Salto de linea
    addi $a0, $zero, 10
    syscall

    # Terminar
    li $v0, 10
    syscall
