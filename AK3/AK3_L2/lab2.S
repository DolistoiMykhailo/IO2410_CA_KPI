// IO24 Dolitsoi M.V

.global lab2
.syntax unified

lab2:
	mov r0, #4
	mov r1, #2
	mov r2, #4
	add r3, r0, r1 // A + B
	cmp r3, #7 // A + B >=< 7
	blt s_1
	bge s_2

s_1:
	and r0, r1 // A AND B
	bl factorial
	mul r0, r4 // (A AND B) * C!
	add r0, #7 // (A AND B) * C! + 7
	pop {pc}

s_2:
	add r0, r1 // A + B
	add r0, r2 // A + B + C
	lsl r0, #1 // (A + B + C) << 1
	pop {pc}

factorial:
	mov r4, #1 // r4 = 1
	cmp r2, #0 // r2 >=< 0
	blt exit // r2 < 0
	beq equal_0 // r2 = 0
	loop:
		mul r4, r2 // r4 = r4 * r2
		sub r2, #1 // r2 = r2 - 1
		cmp r2, #1 // r2 > 1
		bgt loop
	bx lr
exit:
	pop {pc}
equal_0:
	bx lr
