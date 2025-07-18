.global IO24DolitsoiMV_Kursova
.syntax unified
.thumb
.equ NOZK, 2410 

IO24DolitsoiMV_Kursova:
    push {lr}
    ldr r0, =18 // X1
    ldr r1, =-9 // X2
    ldr r2, =23 // X3
    
    mov r6, r1
    mov r7, #2
    sdiv r1, r6, r7 // r1 = X2 / 2
    
    orr r6, r0, r1 // r6 = X1 OR (X2 / 2)
    
    asr r7, r6, #3 // r7 = r6 / 8
        
    mvn r5, r2 //NOTX3
    eor r5, r5, #1 //NOTX3 XOR 1
    mov r3, #-2
    mul r5, r5, r3 // -2 * (NOTX3 XOR 1)

    adds r5, r7, r5 // r5 = result(F)
    
    // Step 1: check for oveflow
    bvs overflow

step2:    
    // Step 2: check or 0
    uxth r0, r5 
    cmp r0, #0
    bne step4_1    
    
    // Step 3: Ry := ZK
    movw r0, #NOZK
    b step4_1

step4_1:
    uxth r0, r5

step4_2:
    // Step 4: Rx := Rx + ZK
    lsrs r1, r5, #16 
    add r1, r1, #NOZK
    lsls r1, r1, #16 
    orr r5, r1, r0

    // Step 5: check for normalization
    lsrs r1, r5, #30
    ands r1, r1, #0x3
    cmp r1, #0
    beq after_norm
    cmp r1, #3
    beq after_norm
    
    // Step 6: normalization correction
    lsr r5, r5, #1

after_norm:
    // Step 7: re-checking the sign bits
    lsrs r1, r5, #30
    ands r1, r1, #0x3
    cmp r1, #1
    beq end
    cmp r1, #2
    beq end

end:
    pop {pc}

overflow:
    lsr r5, r5, #1
    orr r5, r5, #(1 << 31)
    b step2
