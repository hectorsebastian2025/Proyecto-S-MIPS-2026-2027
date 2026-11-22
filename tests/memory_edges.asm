
# Prueba propia 03: Memoria y bytes
# Cobertura:
# lw/sw: offsets positivos y negativos.
# lb/lbu: bit 7 activo en posiciones 0 y 3.
# sb: las cuatro posiciones de una palabra.
# lw: comprueba que sb conserva los otros bytes.
# jal/jr: procedimiento auxiliar de comprobacion.

.text
.globl main

main:
    # -------------------------
    # PRUEBA 1: LW/SW POSITIVO
    # -------------------------
    lui  $t0, 0x807F
    ori  $t0, $t0, 0x20FF

    sw   $t0, 4($gp)
    lw   $t1, 4($gp)
    move $t3, $t0
    jal  print_check

    # -------------------------
    # PRUEBA 2: LW/SW NEGATIVO
    # -------------------------
    sw   $t0, -4($gp)
    lw   $t1, -4($gp)
    move $t3, $t0
    jal  print_check

    # -------------------------
    # PRUEBA 3: LB EN BYTE 0
    # FF debe extenderse a FFFFFFFF
    # -------------------------
    lb    $t1, 4($gp)
    addiu $t3, $zero, -1
    jal   print_check

    # -------------------------
    # PRUEBA 4: LB EN BYTE 3
    # 80 debe extenderse a FFFFFF80
    # -------------------------
    lb    $t1, 7($gp)
    addiu $t3, $zero, -128
    jal   print_check

    # -------------------------
    # PRUEBA 5: LBU EN BYTE 0
    # FF debe extenderse a 000000FF
    # -------------------------
    lbu  $t1, 4($gp)
    ori  $t3, $zero, 255
    jal  print_check

    # -------------------------
    # PRUEBA 6: LBU EN BYTE 3
    # 80 debe extenderse a 00000080
    # -------------------------
    lbu  $t1, 7($gp)
    ori  $t3, $zero, 128
    jal  print_check

    # -------------------------
    # PREPARAR PRUEBAS DE SB
    # Palabra inicial: 11223344
    # -------------------------
    lui  $t0, 0x1122
    ori  $t0, $t0, 0x3344
    sw   $t0, 8($gp)

    # -------------------------
    # PRUEBA 7: SB POSICION 0
    # Esperado: 112233AA
    # -------------------------
    ori  $t2, $zero, 0xAA
    sb   $t2, 8($gp)
    lw   $t1, 8($gp)
    lui  $t3, 0x1122
    ori  $t3, $t3, 0x33AA
    jal  print_check

    # -------------------------
    # PRUEBA 8: SB POSICION 1
    # Esperado: 1122BBAA
    # -------------------------
    ori  $t2, $zero, 0xBB
    sb   $t2, 9($gp)
    lw   $t1, 8($gp)
    lui  $t3, 0x1122
    ori  $t3, $t3, 0xBBAA
    jal  print_check

    # -------------------------
    # PRUEBA 9: SB POSICION 2
    # Esperado: 11CCBBAA
    # -------------------------
    ori  $t2, $zero, 0xCC
    sb   $t2, 10($gp)
    lw   $t1, 8($gp)
    lui  $t3, 0x11CC
    ori  $t3, $t3, 0xBBAA
    jal  print_check

    # -------------------------
    # PRUEBA 10: SB POSICION 3
    # Esperado: DDCCBBAA
    # -------------------------
    ori  $t2, $zero, 0xDD
    sb   $t2, 11($gp)
    lw   $t1, 8($gp)
    lui  $t3, 0xDDCC
    ori  $t3, $t3, 0xBBAA
    jal  print_check

    # Imprimir salto de linea
    addiu $a0, $zero, 10
    addiu $v0, $zero, 11
    syscall

    # Terminar el programa
    addiu $v0, $zero, 10
    syscall

# -------------------------
# PROCEDIMIENTO AUXILIAR
# -------------------------
# t1 = valor obtenido
# t3 = valor esperado
# Imprime 1 si coinciden;
# imprime 0 si no coinciden.

print_check:
    addiu $a0, $zero, 48

    bne   $t1, $t3, print_result

    addiu $a0, $zero, 49

print_result:
    addiu $v0, $zero, 11
    syscall
    jr    $ra
