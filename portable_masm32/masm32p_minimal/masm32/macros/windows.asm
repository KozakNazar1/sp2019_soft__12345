;;**************************** HI-TECH GROUP *****************************
;;			     Windows Macros File
;; VERSION 1.4
;; CREATED 10.07.2003
;; 
;; W A S M . R U [http://wasm.ru]
;;(c) Edmond 2002-2003
;;************************************************************************
;;************************************************************************

;��� ��������� ����������� � ������ � ����� ����������� ������ �� ������
PROGRAM_IMAGE_BASE	EQU	400000h


;=========================================================================
;			CONSTANTS
;=========================================================================
$$$__null		EQU		ebx
$$$__result		EQU		eax
$$$__msg		EQU		edi
$$$__hInstance		EQU		esi
$$$__data		EQU		edx
$$$__counter		EQU		ecx
$$$__base		EQU		ebx
;=========================================================================
;			MACROS
;=========================================================================
;=========================================================================
;���� �������� ������� �������� ��� ��� �����������

$$$WIN32START		macro

PUBLIC	l$_ExitProgram

_start:                       

	xor	ebx,ebx

			endm
;================================================================================
;================================================================================
; ���� �������� ������ ������������ ��� ������� ������ ����������
; ��� ���� �� ��� �������� ��������� �������� ���� �����
        	                                          
$$$WIN32END		macro

l$_ExitProgram:              
  
	push	$$$__null
	call	ExitProcess

	
			end	_start
			
			endm    
;================================================================================
;================================================================================
; ���� ������ ��������� � ����� ������� ������ ��������� ���� ���������.

$$$EXITPROGRAM		macro
  
	push	$$$__null
	call	ExitProcess

			endm
$$$EXITAPP		macro
		jmp	l$_ExitProgram
			endm
;================================================================================
;================================================================================
; ���� ����� ��������� �������� 
; �������������� � ����������� ������� ML, ����������� ����.
; ��������: $$$WARNING "�� �������� ��� ��������� �����!!!"
$$$WARNING		macro text
%echo @CatStr(@FileCur,<(>,%@Line,<)>) : warning note: text
			endm
;================================================================================
;================================================================================
;DLL
$$$DLLSTART		macro
_start@12:

;; ���������, ������� �������� DLL

esp__hDLL		EQU	dword ptr [esp+04h];; ��������� �� ����� DLL
esp__fdwReason		EQU	dword ptr [esp+08h];; ������� ������
esp__fImpLoad		EQU	dword ptr [esp+0ch];; ������ �������� DLL ( 0 ���� ��������� ����)

			endm
			
$$$DLLEND		macro

			mov	al,1
			ret	12
			
			end	_start@12
			
			
			endm
;=========================================================================

$$$DLLFUN		macro	name, status, params:VARARG
;;�������� ������������ ���� status �� ������������ �������������
;;�������� ���������� ��� �������� �������� ����
IFIDNI	<status>,<BEGIN>
GOTO	ml__begin
ELSEIFIDNI <status>,<END>
GOTO	ml__end
ELSE
.ERR <$$$DLLFUN:�������� �������� ��������� �1 (status) - \
	������ ���� :BEGIN ��� END>
ENDIF

			: ml__begin
		push	ebp
		mov	ebp,esp
$__DLLpcount = 0
FOR param, <params>
@CatStr(<ebp__>,param)		EQU	dword ptr [ebp+08h+$__pcount*4]
;% echo @CatStr(%$__DLLpcount)
$__DLLpcount = $__DLLpcount + 1               ; Count the parameters
ENDM
$__DLLpcount = $__DLLpcount*4
@CatStr(<_>,name,<@>,%$__DLLpcount)		proc
PUBLIC	@CatStr(<_>,name,<@>,%$__DLLpcount)
GOTO ml__macroend
			:ml__end
		pop	ebp
		ret	$__DLLpcount
@CatStr(<_>,name,<@>,%$__DLLpcount)		endp
			: ml__macroend
			
			endm  
;=========================================================================
;=========================================================================
; ������� ��� ��������� �����
;=========================================================================
;=========================================================================

$$$_DATAWCHAR			MACRO	char

mp$__n	= 0
mp$__latin		TEXTEQU	@CatStr(' !"#$%&'()*+,<,>,-./0123456789:  = ?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~)
mp$__cyrilic	TEXTEQU	<����������������������������������������������������������������������������������������������>

mp$__char	EQU	<char>
;; ����� � ��������
mp$__n	=	@InStr(1,%mp$__cyrilic,%mp$__char)
IF	mp$__n
;; ���� �����, �����
	IF	mp$__n eq 60h
		mp$__n = 90h
	ELSEIF mp$__n eq 61h
		mp$__n = 91h
	ENDIF
mp$__n = 401h + mp$__n
ELSEIFIDN	<char>,<;>
	;;���� ���� ������ ������������ ;
	mp$__n	=	59
ELSEIFB	<char>
mp$__n = 32
ELSE	
	;; ����� ���� � ��������
	mp$__n	=	@InStr(2,%mp$__latin,%mp$__char)
	mp$__n	=	mp$__n+1eh
ENDIF
				ENDM 
;;=========================================================================
$$$_GETCODEESCCHARA		MACRO	char
;; ���� ���������� ����� ��������� ����������� ������� � �����

IFIDN		<char>,<q>	;; ������� '
mp$__escchar	TEXTEQU	<39>
ELSEIFIDN	<char>,<Q>	;; ������� "
mp$__escchar	TEXTEQU	<34>
ELSEIFIDN	<char>,<t>	;; ���������
mp$__escchar	TEXTEQU	<09h>
ELSEIFIDN	<char>,<0>	;; 0 ����
mp$__escchar	TEXTEQU	<0>
ELSEIFIDN	<char>,<[>	;; >
mp$__escchar	TEXTEQU	<91>
ELSEIFIDN	<char>,<]>	;; <
mp$__escchar	TEXTEQU	<93>
ELSEIFIDN	<char>,<]>	;; <
mp$__escchar	TEXTEQU	<93>
ELSEIFIDN	<char>,<{>	;; �������� �������
mp$__escchar	TEXTEQU	<171>
ELSEIFIDN	<char>,<}>	;; �������� �������
mp$__escchar	TEXTEQU	<187>
ELSEIFIDN	<char>,<c>	;; ��������
mp$__escchar	TEXTEQU	<169>
ELSEIFIDN	<char>,<r>	;; �������� ����
mp$__escchar	TEXTEQU	<174>
ELSEIFIDN	<char>,<(>	;; ������� ������� �������
mp$__escchar	TEXTEQU	<147>
ELSEIFIDN	<char>,<)>	;; ������� ������� �������
mp$__escchar	TEXTEQU	<148>
ELSEIFIDN	<char>,<�>	;; ��������� ������� �������
mp$__escchar	TEXTEQU	<145>
ELSEIFIDN	<char>,<�>	;; ��������� ������� �������
mp$__escchar	TEXTEQU	<146>
ELSEIFIDN	<char>,<T>	;; TM ����
mp$__escchar	TEXTEQU	<153>
ELSEIFIDN	<char>,<&>	;; \
mp$__escchar	TEXTEQU	<92>
ELSEIFIDN	<char>,<n>	;; ������� ������
mp$__escchar	TEXTEQU	<0dh,0ah>
ELSEIFIDN	<char>,<|>	;; ����� ����
mp$__escchar	TEXTEQU	<33>

ELSE
mp$__escchar	TEXTEQU	<>
ENDIF
ENDM
;;=========================================================================

$$$_GETCODEESCCHARW		MACRO	char

;; ���� ���������� ����� ��������� ����������� ������� � �����

IFIDN		<char>,<q>	;; ������� '
mp$__escchar	TEXTEQU	<39>
ELSEIFIDN	<char>,<Q>	;; ������� "
mp$__escchar	TEXTEQU	<34>
ELSEIFIDN	<char>,<t>	;; ���������
mp$__escchar	TEXTEQU	<09h>
ELSEIFIDN	<char>,<0>	;; 0 ����
mp$__escchar	TEXTEQU	<00h>
ELSEIFIDN	<char>,<[>	;; >
mp$__escchar	TEXTEQU	<91>
ELSEIFIDN	<char>,<]>	;; <
mp$__escchar	TEXTEQU	<93>
ELSEIFIDN	<char>,<]>	;; <
mp$__escchar	TEXTEQU	<93>
ELSEIFIDN	<char>,<{>	;; �������� �������
mp$__escchar	TEXTEQU	<0abh>
ELSEIFIDN	<char>,<}>	;; �������� �������
mp$__escchar	TEXTEQU	<0bbh>
ELSEIFIDN	<char>,<c>	;; ��������
mp$__escchar	TEXTEQU	<0a9h>
ELSEIFIDN	<char>,<r>	;; �������� ����
mp$__escchar	TEXTEQU	<0aeh>
ELSEIFIDN	<char>,<(>	;; ������� ������� �������
mp$__escchar	TEXTEQU	<201ch>
ELSEIFIDN	<char>,<)>	;; ������� ������� �������
mp$__escchar	TEXTEQU	<201dh>
ELSEIFIDN	<char>,<�>	;; ��������� ������� �������
mp$__escchar	TEXTEQU	<2018h>
ELSEIFIDN	<char>,<�>	;; ��������� ������� �������
mp$__escchar	TEXTEQU	<2019h>
ELSEIFIDN	<char>,<T>	;; TM ����
mp$__escchar	TEXTEQU	<2122h>
ELSEIFIDN	<char>,<&>	;; \
mp$__escchar	TEXTEQU	<92>
ELSEIFIDN	<char>,<n>	;; ������� ������
mp$__escchar	TEXTEQU	<0dh,0ah>
ELSEIFIDN	<char>,<|>	;; ����� ����
mp$__escchar	TEXTEQU	<33>

ELSE
mp$__escchar	TEXTEQU	<>
ENDIF
ENDM
;;=========================================================================
$$$STRINGA		MACRO	name,string

mp$__string		TEXTEQU	<>
mp$__ni			=	0
mp$__strtype	=	0
mp$__quote1		EQU	<'>
mp$__quote2		EQU	<">
mp$__segcflag	=	0


IFIDNI		@CurSeg,<_TEXT>
mp$__segcflag	=	1
				.const
ENDIF

&name	label	byte

FORC char, <string>
IF	mp$__ni eq	0
;; ��������� ������ ������ ������
	IFIDN	<char>,<'>
	mp$__strtype	=	1
	ELSEIFIDN	<char>,<">
	mp$__strtype	=	2
	ELSE
mp$__string TEXTEQU	@CatStr(%mp$__string,char)
	ENDIF

ELSE	;; �� � ������ ���
	IFIDN	<char>,<'>
		IF	mp$__strtype eq 1
		;; ���� � ������ ���������� � ��������� �������,
		;; ����������� ��������� �������, � ��� ������ �� �����
			IF	mp$__ni eq 1
		.ERR <������ ����������� ������:: �� ���������� ������ ������ ''>
			ENDIF
		;; ������ ������ ��������� � �� ������� �
		@CatStr(< db >,%mp$__quote1,%mp$__string,%mp$__quote1)
		mp$__string TEXTEQU	<>
		EXITM
		ENDIF
	ELSEIFIDN	<char>,<">
		IF	mp$__strtype eq 2
		;; ���� � ������ ���������� � ������� �������,
		;; ����������� ������� �������, � ��� ������ �� �����
		IF	mp$__ni eq 1
		.ERR <������ ����������� ������:: �� ���������� ������ ������ "">
		ENDIF
		;; ������ ������ ��������� � �� ������� �
		@CatStr(< db >,%mp$__quote2,%mp$__string,%mp$__quote2)
		mp$__string TEXTEQU	<>
		EXITM
		ENDIF
	ENDIF
;; �� ����������� ������ �����������?
mp$__xxchar	TEXTEQU	<char>
mp$__string TEXTEQU	@CatStr(%mp$__string,%mp$__xxchar)
ENDIF
mp$__ni	= mp$__ni+1
ENDM

IFNB mp$__string
@CatStr(< db >,%mp$__quote1,%mp$__string,%mp$__quote1)
ENDIF

IF	mp$__segcflag eq 1
					.code
ENDIF
				ENDM

;;=========================================================================
$$$STRINGW		MACRO	name,string

mp$__quote1		EQU	<'>
mp$__quote2		EQU	<">

mp$__segcflag	=	0
IFIDNI		@CurSeg,<_TEXT>
mp$__segcflag	=	1
				.const
ENDIF

&name	label	word

mp$__string		TEXTEQU	<>
mp$__ni			=	0
mp$__strtype	=	0


FORC char, <string>

IF	mp$__ni eq	0
;; ��������� ������ ������ ������
	IFIDN	<char>,<'>
	mp$__strtype	=	1
	ELSEIFIDN	<char>,<">
	mp$__strtype	=	2
;;	ELSE
;;.ERR <������ ����������� ������ ������ ������ ������ ���� " ��� '>
	ENDIF

ELSE	;; �� � ������ ���

	IFIDN	<char>,<'>
		IF	mp$__strtype eq 1
		;; ���� � ������ ���������� � ��������� �������,
		;; ����������� ��������� �������, � ��� ������ �� �����
			IF	mp$__ni eq 1
			.ERR <������ ����������� ������:: �� ���������� ������ ������ ''>
			ENDIF
		;; ������ ������ ��������� � �� ������� �
		EXITM
		ENDIF
	ELSEIFIDN	<char>,<">
		IF	mp$__strtype eq 2
		;; ���� � ������ ���������� � ������� �������,
		;; ����������� ������� �������, � ��� ������ �� �����
			IF	mp$__ni eq 1
			.ERR <������ ����������� ������:: �� ���������� ������ ������ "">
			ENDIF
		;; ������ ������ ��������� � �� ������� �
		EXITM
		ENDIF
	ENDIF
;; �� ����������� ������ �����������?
;; ��������� ��� ������
$$$_DATAWCHAR	char
	IF @SizeStr(%mp$__string) gt 120
	@CatStr(< dw >,%mp$__string)
	mp$__string TEXTEQU	@CatStr(%mp$__n)
	mp$__ni	=	1
	ELSE

		IF	mp$__ni eq 1
mp$__string TEXTEQU	@CatStr(%mp$__n)
		ELSE
mp$__string TEXTEQU	@CatStr(%mp$__string,<,>,%mp$__n)
		ENDIF
	ENDIF
ENDIF
mp$__ni	= mp$__ni+1
ENDM

@CatStr(< dw >,%mp$__string)
IF	mp$__segcflag eq 1
			.code
ENDIF
				ENDM

;;=========================================================================

$$$ESCSTRINGA		MACRO	name,string

mp$__string		TEXTEQU	<>
mp$__ni			=	0
mp$__strtype	=	0
mp$__fescchar	=	0
mp$__quote1		EQU	<'>
mp$__quote2		EQU	<">
mp$__segcflag	=	0

IFIDNI		@CurSeg,<_TEXT>
mp$__segcflag	=	1
				.const
ENDIF

&name	label	byte

FORC char, <string>
IF	mp$__ni eq	0
;; ��������� ������ ������ ������
	IFIDN	<char>,<'>
	mp$__strtype	=	1
	ELSEIFIDN	<char>,<">
	mp$__strtype	=	2
	ELSE
mp$__string TEXTEQU	@CatStr(%mp$__string,char)
	ENDIF

ELSE	;; �� � ������ ���

;; �������� �� ����������� ������
	IFIDN	<char>,<\>
		IF	mp$__fescchar eq 0
		mp$__fescchar	=	1
		ENDIF
	GOTO ml$__next
	ENDIF

	IF	mp$__fescchar eq 1
	$$$_GETCODEESCCHARA char
		IFB	mp$__escchar
	;; ���� ������������ ������� ������������
	;; �� �� ��������� � ������ ����� ����
	mp$__string TEXTEQU	@CatStr(%mp$__string,<\>,char)
	ELSE
		IF @SizeStr(%mp$__string) gt 0
		@CatStr(< db >,%mp$__quote1,%mp$__string,%mp$__quote1)
		ENDIF
		@CatStr(< db >,%mp$__escchar)
		mp$__string TEXTEQU	<>
		mp$__ni			=	0
		ENDIF
	mp$__fescchar	=	0;
	GOTO	ml$__next
	ENDIF

	IFIDN	<char>,<'>
		IF	mp$__strtype eq 1
		;; ���� � ������ ���������� � ��������� �������,
		;; ����������� ��������� �������, � ��� ������ �� �����
			IF	mp$__ni eq 1
			EXITM
			ENDIF
		;; ������ ������ ��������� � �� ������� �
		@CatStr(< db >,%mp$__quote1,%mp$__string,%mp$__quote1)
		mp$__string TEXTEQU	<>
		EXITM
		ENDIF
	ELSEIFIDN	<char>,<">
		IF	mp$__strtype eq 2
		;; ���� � ������ ���������� � ������� �������,
		;; ����������� ������� �������, � ��� ������ �� �����
		IF	mp$__ni eq 1
		EXITM
		ENDIF
		;; ������ ������ ��������� � �� ������� �
		@CatStr(< db >,%mp$__quote2,%mp$__string,%mp$__quote2)
		mp$__string TEXTEQU	<>
		EXITM
		ENDIF
	ENDIF
;; �� ����������� ������ �����������?
mp$__xxchar	TEXTEQU	<char>
mp$__string TEXTEQU	@CatStr(%mp$__string,%mp$__xxchar)
ENDIF

				:ml$__next
mp$__ni	= mp$__ni+1
ENDM

IFNB mp$__string
@CatStr(< db >,%mp$__quote1,%mp$__string,%mp$__quote1)
ENDIF

IF	mp$__segcflag eq 1
					.code
ENDIF
				ENDM

;;=========================================================================
$$$ESCSTRINGW		MACRO	name,string

mp$__quote1		EQU	<'>
mp$__quote2		EQU	<">

mp$__fescchar	=	0
mp$__segcflag	=	0
IFIDNI		@CurSeg,<_TEXT>
mp$__segcflag	=	1
				.const
ENDIF

&name	label	word

mp$__string		TEXTEQU	<>
mp$__ni		=	0
mp$__strtype	=	0


FORC char, <string>

IF	mp$__ni eq	0
;; ��������� ������ ������ ������
	IFIDN	<char>,<'>
	mp$__strtype	=	1
	ELSEIFIDN	<char>,<">
	mp$__strtype	=	2
;;	ELSE
;;.ERR <������ ����������� ������ ������ ������ ������ ���� " ��� '>
	ENDIF

ELSE	;; �� � ������ ���

	IFIDN	<char>,<\>
		IF	mp$__fescchar eq 0
		mp$__fescchar	=	1
		ENDIF
	GOTO ml$__next
	ENDIF

	IF	mp$__fescchar eq 1
	$$$_GETCODEESCCHARW char
		IFB	mp$__escchar
	;; ���� ������������ ������� ������������
	;; �� �� ��������� � ������ ����� ����
		$$$_DATAWCHAR	char
			IF	mp$__ni eq 2
			mp$__string TEXTEQU	@CatStr(<5ch>,<,>,%mp$__n)
			ELSE
			mp$__string TEXTEQU	@CatStr(%mp$__string,<,>,<5ch>,<,>,%mp$__n)
			ENDIF
		ELSE
			IF	mp$__ni eq 2
			mp$__string TEXTEQU	@CatStr(%mp$__escchar)
			ELSE
			mp$__string TEXTEQU	@CatStr(%mp$__string,<,>,%mp$__escchar)
			ENDIF
		ENDIF
	mp$__fescchar	=	0;
	GOTO	ml$__next
	ENDIF

	IFIDN	<char>,<'>
		IF	mp$__strtype eq 1
		;; ���� � ������ ���������� � ��������� �������,
		;; ����������� ��������� �������, � ��� ������ �� �����
			IF	mp$__ni eq 1
			.ERR <������ ����������� ������:: �� ���������� ������ ������ ''>
			ENDIF
		;; ������ ������ ��������� � �� ������� �
		EXITM
		ENDIF
	ELSEIFIDN	<char>,<">
		IF	mp$__strtype eq 2
		;; ���� � ������ ���������� � ������� �������,
		;; ����������� ������� �������, � ��� ������ �� �����
			IF	mp$__ni eq 1
			.ERR <������ ����������� ������:: �� ���������� ������ ������ "">
			ENDIF
		;; ������ ������ ��������� � �� ������� �
		EXITM
		ENDIF
	ENDIF
;; �� ����������� ������ �����������?
;; ��������� ��� ������
$$$_DATAWCHAR	char
	IF @SizeStr(%mp$__string) gt 120
	@CatStr(< dw >,%mp$__string)
	mp$__string TEXTEQU	@CatStr(%mp$__n)
	mp$__ni	=	1
	ELSE
									
		IF	mp$__ni eq 1
mp$__string TEXTEQU	@CatStr(%mp$__n)
		ELSE
mp$__string TEXTEQU	@CatStr(%mp$__string,<,>,%mp$__n)
		ENDIF
	ENDIF
ENDIF
		:ml$__next
	
mp$__ni	= mp$__ni+1
ENDM

@CatStr(< dw >,%mp$__string)
IF	mp$__segcflag eq 1
					.code
ENDIF
				ENDM

;;=========================================================================

$$$STRING		MACRO	name,string
;; ���� ������ ���������� �������� �����
IFDEF	UNICODE_DEF
$$$STRINGW	name,string
ELSE
$$$STRINGA	name,string
ENDIF

				ENDM

;;=========================================================================
$$$ESCSTRING		MACRO	name,string
;; ���� ������ ���������� �������� �����
IFDEF	UNICODE_DEF
$$$ESCSTRINGW	name,string
ELSE
$$$ESCSTRINGA	name,string
ENDIF

				ENDM
;;=========================================================================
$$$ZSTRINGA		MACRO	name,string
;; ���� ������ ���������� �������� �����
$$$STRINGA	name,string
IF	mp$__segcflag eq 1
			.const
ENDIF
	db	00h
IF	mp$__segcflag eq 1
			.code
ENDIF
				ENDM

;;=========================================================================
$$$ZSTRINGW		MACRO	name,string
;; ���� ������ ���������� �������� �����
$$$STRINGW	name,string
IF	mp$__segcflag eq 1
			.const
ENDIF
	dw	00h
IF	mp$__segcflag eq 1
			.code
ENDIF
			ENDM
;;=========================================================================
$$$ZSTRING		MACRO	name,string
;; ���� ������ ���������� �������� �����
IFDEF	UNICODE_DEF
$$$ZSTRINGW	name,string
ELSE
$$$ZSTRINGA	name,string
ENDIF
			ENDM
;;=========================================================================
$$$ESCZSTRINGA		MACRO	name,string
;; ���� ������ ���������� �������� �����
$$$ESCSTRINGA	name,string
IF	mp$__segcflag eq 1
			.const
ENDIF
	db	00h
IF	mp$__segcflag eq 1
			.code
ENDIF
				ENDM

;;=========================================================================
$$$ESCZSTRINGW		MACRO	name,string
;; ���� ������ ���������� �������� �����
$$$ESCSTRINGW	name,string
IF	mp$__segcflag eq 1
			.const
ENDIF
	dw	00h
IF	mp$__segcflag eq 1
			.code
ENDIF
				ENDM

;;=========================================================================
$$$ESCZSTRING		MACRO	name,string
;; ���� ������ ���������� �������� �����
IFDEF	UNICODE_DEF
$$$ESCZSTRINGW	name,string
ELSE
$$$ESCZSTRINGA	name,string
ENDIF

				ENDM
;;=========================================================================
;;=========================================================================
;; 			�������� �����
;; 	����� ��� ����������� ��������� ���������� ��������
;;=========================================================================
;;=========================================================================
$$$STACKFRAME		macro	status,params:VARARG
;; ������, ������� ������������� ������ ����� ��� ���������
;; npparam - ���������� ���������� ���������
;; �������� ������������ ���� status �� ������������ �������������
;; �������� ���������� ��� �������� �������� ����
IFIDNI	<status>,<BEGIN>
GOTO	ml__begin
ELSEIFIDNI <status>,<END>
GOTO	ml__end
ELSEIFIDNI <status>,<ALIGN>
GOTO	ml__align
ELSE
.ERR <$$$STACKFRAME:�������� �������� ��������� �1 (status) - \
	������ ���� :BEGIN, END ��� ALIGN>
ENDIF
			: ml__align
IFB <params>
;; ���� �������� ������������ ����� 0, ������ ������������ ���
$__stackframe_align = 0
ELSE
$__stackframe_align = params
;; ������ ����� ��� ������������ �������� esp
$__stackframe_align = not $__stackframe_align
ENDIF
GOTO ml__macroend
			: ml__begin
$__pcount = 0
FOR param, <params>
@CatStr(<ebp__>,param,< EQU >,<!<dword ptr [ebp+>,%(08h+$__pcount*4),<]!>>)
$__pcount = $__pcount + 1	;; Count the parameters
ENDM
$__funparam	= $__pcount*4

IF $__funparam ne 0
	push	ebp
	mov	ebp,esp
	IF $__stackframe_align ne 0
	push	ebp
	and	esp,$__stackframe_align
	ENDIF
ENDIF

GOTO ml__macroend
			:ml__end
		$__funparam	=	0
	IF $__stackframe_align ne 0
		pop	ebp
	$__stackframe_align = 0
	ENDIF
		pop	ebp
IFIDNI	<params>,<RET>
		ret	$__pcount*4
ENDIF
			: ml__macroend
			endm  
			
;=======================================================================
;=========================================================================

$$$LOCAL		macro	status
;; �����, ������� ���������� ����������� ��������� ����������
;; �������� ������������ ���� status �� ������������ �������������
;; �������� ���������� ��� �������� �������� ����
IFIDNI	<status>,<BEGIN>
GOTO	ml__begin
ELSEIFIDNI <status>,<DEL>
GOTO	ml__del
ELSEIFIDNI <status>,<END>
GOTO	ml__end
ELSE
.ERR <$$$LOCAL:�������� �������� ��������� �1 (status) - \
	������ ���� :BEGIN ��� END>
ENDIF

			: ml__begin
$__stecksize		=	0
$__varcount		=	0
;; ��������, ��� �� �������� �������� ����
IF	$__funparam	eq	0
;; ���� ��������� ����� ���, ������ ���
			push 	ebp
			mov	ebp,esp
ENDIF
GOTO ml__macroend
			:ml__del
			add	esp,@CatStr(%$__stecksize)
GOTO ml__macroend			
			:ml__end
;; �������� � ����� ������� ������ ������� ��������
IF	$__stecksize	ne	0
			sub	esp,@CatStr(%$__stecksize)
ENDIF
;; $__stecksize	=	0
			: ml__macroend
			endm  
			
;=======================================================================
;=========================================================================

$$$LVARS		macro	params:VARARG
FOR param, <params>
@CatStr(<l_>,param)	EQU	dword ptr [ebp+08h+$__varcount*4]
$__varcount = $__varcount + 1               ; Count the parameters
ENDM
$__stecksize	=	$__stecksize+$__varcount*4
GOTO ml__macroend
				:ml__macroend
			endm  
	
;=======================================================================

;;======================================================================
;;======================================================================
;; ����� ��� ��������� ������
;;======================================================================
;;======================================================================
;;
;;  A language ID is a 16 bit value which is the combination of a
;;  primary language ID and a secondary language ID.  The bits are
;;  allocated as follows:
;;
;;       +-----------------------+-------------------------+
;;       |     Sublanguage ID    |   Primary Language ID   |
;;       +-----------------------+-------------------------+
;;        15                   10 9                       0   bit
;;
;;
;;  Language ID creation/extraction macros:
;;
;;    MAKELANGID    - construct language id from a primary language id and
;;                    a sublanguage id.
;;    PRIMARYLANGID - extract primary language id from a language id.
;;    SUBLANGID     - extract sublanguage id from a language id.
;;
  
$$$MAKELANGID		macro p:REQ,s:REQ
m$__langid = (s SHL 10) or p
			EXITM <m$__langid>
			endm

$$$PRIMARYLANGID	macro lgid:REQ
m$__langid = lgid and 03ffh
			EXITM <m$__langid>
			endm

$$$SUBLANGID		macro lgid:REQ
m$__langid = lgid SHR 10    
			EXITM <m$__langid>
			endm
