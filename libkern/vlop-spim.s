TEXT	_mulv(SB), $0
	MOVW	4(FP), R2
	MOVW	8(FP), R3
	MOVW	12(FP), R4
	MOVW	16(FP), R5
	MULU	R4, R2
	MOVW	LO, R6
	MOVW	HI, R7
	MULU	R3, R4
	MOVW	LO, R8
	ADDU	R8, R7
	MULU	R2, R5
	MOVW	LO, R8
	ADDU	R8, R7
	MOVW	R6, 0(R1)
	MOVW	R7, 4(R1)
	RET
