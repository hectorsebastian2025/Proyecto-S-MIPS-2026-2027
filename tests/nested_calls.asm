
# Prueba propia 05: Llamadas anidadas
# Cobertura:
# jal y jr: procedimiento no hoja que llama a otro.
# sw/lw: guardar y restaurar $ra y $s0 en la pila.
# addiu: desplazamiento negativo y positivo.
# Comprobacion de retorno correcto y preservacion
# de registros.
#
# Salida esperada: 493

.text
.globl main

main:
    # Valor original de s0
    addiu $s0, $zero, 3

    # Llamar al procedimiento externo
    jal outer

    # Al regresar, s0 debe seguir valiendo 3
    addiu $a0, $s0, 48
    addiu $v0, $zero, 11
    syscall

    # Salto de linea
    addiu $a0, $zero, 10
    syscall

    # Finalizar
    addiu $v0, $zero, 10
    syscall


# ---------------------------------
# PROCEDIMIENTO EXTERNO (NO HOJA)
# ---------------------------------

outer:
    # Reservar 8 bytes en la pila
    addiu $sp, $sp, -8

    # Guardar direccion de retorno y s0
    sw $ra, 4($sp)
    sw $s0, 0($sp)

    # Modificar s0 temporalmente
    addiu $s0, $zero, 5

    # Llamar al procedimiento interno
    jal inner

    # inner devuelve t0 = 4
    # Calcular 4 + 5 = 9
    add $t1, $t0, $s0

    # Imprimir 9
    addiu $a0, $t1, 48
    addiu $v0, $zero, 11
    syscall

    # Restaurar registros guardados
    lw $s0, 0($sp)
    lw $ra, 4($sp)

    # Liberar los 8 bytes
    addiu $sp, $sp, 8

    # Regresar a main
    jr $ra


# ---------------------------------
# PROCEDIMIENTO INTERNO (HOJA)
# ---------------------------------

inner:
    # Calcular 2 + 2 = 4
    addiu $t2, $zero, 2
    addu $t0, $t2, $t2

    # Imprimir 4
    addiu $a0, $t0, 48
    addiu $v0, $zero, 11
    syscall

    # Regresar a outer
    jr $ra
