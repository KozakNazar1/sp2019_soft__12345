.586
.model flat;(I) 
;.model flat, c;(II)
.data
temp tbyte 0
K equ 00025630h; (153136d)
.code
_calcLab3 PROC;(I)
;calcLab3 PROC;(II)
    finit
    push ebp
	mov ebp, esp

	mov dword ptr temp, K
	fild qword ptr temp
	fadd qword ptr [ebp + 8]  ; K + B2

	fld qword ptr [ebp + 20]
	fdiv dword ptr [ebp + 16]
	fchs
	fadd                      ; X = K + B2 - D2/C1
	
	fld dword ptr [ebp + 28]
	fmul qword ptr [ebp + 32]
	fadd                      ; X = K + B2 - D2/C1 + E1*F2
	
	pop ebp
	ret

_calcLab3 ENDP;(I)
;calcLab3 ENDP;(II)
END