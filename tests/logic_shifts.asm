
# Prueba propia 02: Logica y desplazamientos
# Cobertura: and, or, andi, ori, lui,
# sll (shamt=0 y 1), srl (0, 16 y 31),
# slt y slti con resultados 0 y 1.
# Incluye operandos negativos y bits altos activos.

.text
.globl main

main:
    addi $v0, $zero, 11

    # t0 = 0x80018001 (negativo)
    lui $t0, 0x8001
    ori $t0, $t0, 0x8001

    # t1 = 0x0F0F00F0 (positivo)
    lui $t1, 0x0F0F
    ori $t1, $t1, 0x00F0

    # AND = 0x00010000 -> imprime 1
    and $t2, $t0, $t1
    srl $t3, $t2, 16
    addi $a0, $t3, 48
    syscall

    # OR = 0x8F0F80F1
    # Los 4 bits altos valen 8 -> imprime 8
    or $t2, $t0, $t1
    srl $t3, $t2, 28
    addi $a0, $t3, 48
    syscall

    # ANDI debe extender con ceros
    # El resultado es positivo -> imprime 0
    andi $t2, $t0, 0x8000
    slt $t3, $t2, $zero
    addi $a0, $t3, 48
    syscall

    # ORI debe extender con ceros
    # Resultado 0x00008001 -> imprime 0
    ori $t2, $zero, 0x8001
    slt $t3, $t2, $zero
    addi $a0, $t3, 48
    syscall

    # LUI con bit 15 activo
    # 0x80010000 es negativo -> imprime 1
    lui $t2, 0x8001
    slt $t3, $t2, $zero
    addi $a0, $t3, 48
    syscall

    # SLL con desplazamiento 0 -> 3
    addi $t4, $zero, 3
    sll $t2, $t4, 0
    addi $a0, $t2, 48
    syscall

    # SLL con desplazamiento 1 -> 6
    sll $t2, $t4, 1
    addi $a0, $t2, 48
    syscall

    # SRL con desplazamiento 0
    # Conserva el valor negativo -> 1
    srl $t2, $t0, 0
    slt $t3, $t2, $zero
    addi $a0, $t3, 48
    syscall

    # SRL sobre negativo, desplazamiento 31
    # Debe producir 1
    srl $t2, $t0, 31
    addi $a0, $t2, 48
    syscall

    # SRL sobre negativo, desplazamiento 16
    # Debe introducir ceros: positivo -> 0
    srl $t2, $t0, 16
    slt $t3, $t2, $zero
    addi $a0, $t3, 48
    syscall

    # SLT: negativo < positivo -> 1
    slt $t3, $t0, $t1
    addi $a0, $t3, 48
    syscall

    # SLT: positivo < negativo -> 0
    slt $t3, $t1, $t0
    addi $a0, $t3, 48
    syscall

    # SLTI: negativo < 0 -> 1
    slti $t3, $t0, 0
    addi $a0, $t3, 48
    syscall

    # SLTI: positivo < -1 -> 0
    slti $t3, $t1, -1
    addi $a0, $t3, 48
    syscall

    # Salto de linea
    addi $a0, $zero, 10
    syscall

    # Terminar
    addi $v0, $zero, 10
    syscall
