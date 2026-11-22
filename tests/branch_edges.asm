
# Prueba propia 04: Saltos y bucles
# Cobertura:
# beq: tomado y no tomado
# bne: tomado y no tomado
# bne: salto hacia atras
# j: salto incondicional
# Los caracteres impresos dependen de los resultados.

.text
.globl main

main:
    addiu $v0, $zero, 11

    # PRUEBA 1: BEQ TOMADO
    # Esperado: 0
    addiu $t0, $zero, 5
    addiu $t1, $zero, 5
    addiu $t2, $zero, 0

    beq $t0, $t1, beq_taken
    addiu $t2, $zero, 9

beq_taken:
    addiu $a0, $t2, 48
    syscall

    # PRUEBA 2: BEQ NO TOMADO
    # Esperado: 1
    addiu $t1, $zero, 6
    addiu $t2, $zero, 0

    beq $t0, $t1, beq_not_taken
    addiu $t2, $zero, 1

beq_not_taken:
    addiu $a0, $t2, 48
    syscall

    # PRUEBA 3: BNE TOMADO
    # Esperado: 0
    addiu $t2, $zero, 0

    bne $t0, $t1, bne_taken
    addiu $t2, $zero, 9

bne_taken:
    addiu $a0, $t2, 48
    syscall

    # PRUEBA 4: BNE NO TOMADO
    # Esperado: 1
    addiu $t1, $zero, 5
    addiu $t2, $zero, 0

    bne $t0, $t1, bne_not_taken
    addiu $t2, $zero, 1

bne_not_taken:
    addiu $a0, $t2, 48
    syscall

    # PRUEBA 5: SALTO HACIA ATRAS
    # Repetir cuatro veces
    # Esperado: 4
    addiu $t3, $zero, 0
    addiu $t4, $zero, 4

loop:
    addiu $t3, $t3, 1
    bne $t3, $t4, loop

    addiu $a0, $t3, 48
    syscall

    # PRUEBA 6: SALTO INCONDICIONAL
    # Esperado: 7
    addiu $t5, $zero, 0

    j jump_target
    addiu $t5, $zero, 9

jump_target:
    addiu $t5, $t5, 7
    addiu $a0, $t5, 48
    syscall

    # Salto de linea
    addiu $a0, $zero, 10
    syscall

    # Terminar
    addiu $v0, $zero, 10
    syscall
