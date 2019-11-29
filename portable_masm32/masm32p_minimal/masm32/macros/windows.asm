;;**************************** HI-TECH GROUP *****************************
;;			     Windows Macros File
;; VERSION 1.4
;; CREATED 10.07.2003
;; 
;; W A S M . R U [http://wasm.ru]
;;(c) Edmond 2002-2003
;;************************************************************************
;;************************************************************************

;Эта программа фиксирована в памяти и может запуститься только по адресу
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
;Этим макросом следует начинать ваш код прилоожения

$$$WIN32START		macro

PUBLIC	l$_ExitProgram

_start:                       

	xor	ebx,ebx

			endm
;================================================================================
;================================================================================
; Этим макросом должен оканчиваться ваш главный модуль приложения
; При этом эа ним недолжно следовать никакого кода более
        	                                          
$$$WIN32END		macro

l$_ExitProgram:              
  
	push	$$$__null
	call	ExitProcess

	
			end	_start
			
			endm    
;================================================================================
;================================================================================
; Этот макрос вызванный в вашем главном модуле завершает вашу программу.

$$$EXITPROGRAM		macro
  
	push	$$$__null
	call	ExitProcess

			endm
$$$EXITAPP		macro
		jmp	l$_ExitProgram
			endm
;================================================================================
;================================================================================
; Этот макро позваляет выводить 
; предупреждения в стандартном формате ML, определённые вами.
; Например: $$$WARNING "Не забутьте это исправить потом!!!"
$$$WARNING		macro text
%echo @CatStr(@FileCur,<(>,%@Line,<)>) : warning note: text
			endm
;================================================================================
;================================================================================
;DLL
$$$DLLSTART		macro
_start@12:

;; Параметры, которые получает DLL

esp__hDLL		EQU	dword ptr [esp+04h];; указатель на образ DLL
esp__fdwReason		EQU	dword ptr [esp+08h];; Причина вызова
esp__fImpLoad		EQU	dword ptr [esp+0ch];; Способ загрузки DLL ( 0 если загружена явно)

			endm
			
$$$DLLEND		macro

			mov	al,1
			ret	12
			
			end	_start@12
			
			
			endm
;=========================================================================

$$$DLLFUN		macro	name, status, params:VARARG
;;Проверка корректности поля status на корректность использования
;;Проверка происходит без различия регистра букв
IFIDNI	<status>,<BEGIN>
GOTO	ml__begin
ELSEIFIDNI <status>,<END>
GOTO	ml__end
ELSE
.ERR <$$$DLLFUN:неверное значение параметра №1 (status) - \
	должен быть :BEGIN или END>
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
; Макросы для обработки строк
;=========================================================================
;=========================================================================

$$$_DATAWCHAR			MACRO	char

mp$__n	= 0
mp$__latin		TEXTEQU	@CatStr(' !"#$%&'()*+,<,>,-./0123456789:  = ?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~)
mp$__cyrilic	TEXTEQU	<ЁЂЃЄЅІЇЈЉЊЋЌЎЏАБВГДЕЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдежзийклмнопрстуфхцчшщъыьэюяёђѓєѕіїјљњћќўџҐґ>

mp$__char	EQU	<char>
;; Найти в кирилице
mp$__n	=	@InStr(1,%mp$__cyrilic,%mp$__char)
IF	mp$__n
;; Если нашли, тогда
	IF	mp$__n eq 60h
		mp$__n = 90h
	ELSEIF mp$__n eq 61h
		mp$__n = 91h
	ENDIF
mp$__n = 401h + mp$__n
ELSEIFIDN	<char>,<;>
	;;Если этот символ соотвествует ;
	mp$__n	=	59
ELSEIFB	<char>
mp$__n = 32
ELSE	
	;; Иначе ищем в латинице
	mp$__n	=	@InStr(2,%mp$__latin,%mp$__char)
	mp$__n	=	mp$__n+1eh
ENDIF
				ENDM 
;;=========================================================================
$$$_GETCODEESCCHARA		MACRO	char
;; Этот внутренний макро переводит специальные символы в цифры

IFIDN		<char>,<q>	;; Ковычка '
mp$__escchar	TEXTEQU	<39>
ELSEIFIDN	<char>,<Q>	;; Ковычка "
mp$__escchar	TEXTEQU	<34>
ELSEIFIDN	<char>,<t>	;; Табуляция
mp$__escchar	TEXTEQU	<09h>
ELSEIFIDN	<char>,<0>	;; 0 ноль
mp$__escchar	TEXTEQU	<0>
ELSEIFIDN	<char>,<[>	;; >
mp$__escchar	TEXTEQU	<91>
ELSEIFIDN	<char>,<]>	;; <
mp$__escchar	TEXTEQU	<93>
ELSEIFIDN	<char>,<]>	;; <
mp$__escchar	TEXTEQU	<93>
ELSEIFIDN	<char>,<{>	;; Фигурные ковычки
mp$__escchar	TEXTEQU	<171>
ELSEIFIDN	<char>,<}>	;; Фигурные ковычки
mp$__escchar	TEXTEQU	<187>
ELSEIFIDN	<char>,<c>	;; Копирайт
mp$__escchar	TEXTEQU	<169>
ELSEIFIDN	<char>,<r>	;; Товарный знак
mp$__escchar	TEXTEQU	<174>
ELSEIFIDN	<char>,<(>	;; Двойные русские ковычки
mp$__escchar	TEXTEQU	<147>
ELSEIFIDN	<char>,<)>	;; Двойные русские ковычки
mp$__escchar	TEXTEQU	<148>
ELSEIFIDN	<char>,<к>	;; Одинарные русские ковычки
mp$__escchar	TEXTEQU	<145>
ELSEIFIDN	<char>,<п>	;; Одинарные русские ковычки
mp$__escchar	TEXTEQU	<146>
ELSEIFIDN	<char>,<T>	;; TM знак
mp$__escchar	TEXTEQU	<153>
ELSEIFIDN	<char>,<&>	;; \
mp$__escchar	TEXTEQU	<92>
ELSEIFIDN	<char>,<n>	;; Перевод строки
mp$__escchar	TEXTEQU	<0dh,0ah>
ELSEIFIDN	<char>,<|>	;; Воскл знак
mp$__escchar	TEXTEQU	<33>

ELSE
mp$__escchar	TEXTEQU	<>
ENDIF
ENDM
;;=========================================================================

$$$_GETCODEESCCHARW		MACRO	char

;; Этот внутренний макро переводит специальные символы в цифры

IFIDN		<char>,<q>	;; Ковычка '
mp$__escchar	TEXTEQU	<39>
ELSEIFIDN	<char>,<Q>	;; Ковычка "
mp$__escchar	TEXTEQU	<34>
ELSEIFIDN	<char>,<t>	;; Табуляция
mp$__escchar	TEXTEQU	<09h>
ELSEIFIDN	<char>,<0>	;; 0 ноль
mp$__escchar	TEXTEQU	<00h>
ELSEIFIDN	<char>,<[>	;; >
mp$__escchar	TEXTEQU	<91>
ELSEIFIDN	<char>,<]>	;; <
mp$__escchar	TEXTEQU	<93>
ELSEIFIDN	<char>,<]>	;; <
mp$__escchar	TEXTEQU	<93>
ELSEIFIDN	<char>,<{>	;; Фигурные ковычки
mp$__escchar	TEXTEQU	<0abh>
ELSEIFIDN	<char>,<}>	;; Фигурные ковычки
mp$__escchar	TEXTEQU	<0bbh>
ELSEIFIDN	<char>,<c>	;; Копирайт
mp$__escchar	TEXTEQU	<0a9h>
ELSEIFIDN	<char>,<r>	;; Товарный знак
mp$__escchar	TEXTEQU	<0aeh>
ELSEIFIDN	<char>,<(>	;; Двойные русские ковычки
mp$__escchar	TEXTEQU	<201ch>
ELSEIFIDN	<char>,<)>	;; Двойные русские ковычки
mp$__escchar	TEXTEQU	<201dh>
ELSEIFIDN	<char>,<к>	;; Одинарные русские ковычки
mp$__escchar	TEXTEQU	<2018h>
ELSEIFIDN	<char>,<п>	;; Одинарные русские ковычки
mp$__escchar	TEXTEQU	<2019h>
ELSEIFIDN	<char>,<T>	;; TM знак
mp$__escchar	TEXTEQU	<2122h>
ELSEIFIDN	<char>,<&>	;; \
mp$__escchar	TEXTEQU	<92>
ELSEIFIDN	<char>,<n>	;; Перевод строки
mp$__escchar	TEXTEQU	<0dh,0ah>
ELSEIFIDN	<char>,<|>	;; Воскл знак
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
;; Проверяем первый символ строки
	IFIDN	<char>,<'>
	mp$__strtype	=	1
	ELSEIFIDN	<char>,<">
	mp$__strtype	=	2
	ELSE
mp$__string TEXTEQU	@CatStr(%mp$__string,char)
	ENDIF

ELSE	;; Не в первый раз
	IFIDN	<char>,<'>
		IF	mp$__strtype eq 1
		;; Если в строке начавшейся с одинарной ковычки,
		;; встретилась одинарная ковычка, и эта строка не пуста
			IF	mp$__ni eq 1
		.ERR <Ошибка определения строки:: Вы определили пустую строку ''>
			ENDIF
		;; Значит строка закончена и мы выводим её
		@CatStr(< db >,%mp$__quote1,%mp$__string,%mp$__quote1)
		mp$__string TEXTEQU	<>
		EXITM
		ENDIF
	ELSEIFIDN	<char>,<">
		IF	mp$__strtype eq 2
		;; Если в строке начавшейся с двойной ковычки,
		;; встретилась двойная ковычка, и эта строка не пуста
		IF	mp$__ni eq 1
		.ERR <Ошибка определения строки:: Вы определили пустую строку "">
		ENDIF
		;; Значит строка закончена и мы выводим её
		@CatStr(< db >,%mp$__quote2,%mp$__string,%mp$__quote2)
		mp$__string TEXTEQU	<>
		EXITM
		ENDIF
	ENDIF
;; Не встретилось ничего интересного?
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
;; Проверяем первый символ строки
	IFIDN	<char>,<'>
	mp$__strtype	=	1
	ELSEIFIDN	<char>,<">
	mp$__strtype	=	2
;;	ELSE
;;.ERR <Ошибка определения строки первый символ обязан быть " или '>
	ENDIF

ELSE	;; Не в первый раз

	IFIDN	<char>,<'>
		IF	mp$__strtype eq 1
		;; Если в строке начавшейся с одинарной ковычки,
		;; встретилась одинарная ковычка, и эта строка не пуста
			IF	mp$__ni eq 1
			.ERR <Ошибка определения строки:: Вы определили пустую строку ''>
			ENDIF
		;; Значит строка закончена и мы выводим её
		EXITM
		ENDIF
	ELSEIFIDN	<char>,<">
		IF	mp$__strtype eq 2
		;; Если в строке начавшейся с двойной ковычки,
		;; встретилась двойная ковычка, и эта строка не пуста
			IF	mp$__ni eq 1
			.ERR <Ошибка определения строки:: Вы определили пустую строку "">
			ENDIF
		;; Значит строка закончена и мы выводим её
		EXITM
		ENDIF
	ENDIF
;; Не встретилось ничего интересного?
;; Добавляем ещё символ
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
;; Проверяем первый символ строки
	IFIDN	<char>,<'>
	mp$__strtype	=	1
	ELSEIFIDN	<char>,<">
	mp$__strtype	=	2
	ELSE
mp$__string TEXTEQU	@CatStr(%mp$__string,char)
	ENDIF

ELSE	;; Не в первый раз

;; Проверка на управляющий символ
	IFIDN	<char>,<\>
		IF	mp$__fescchar eq 0
		mp$__fescchar	=	1
		ENDIF
	GOTO ml$__next
	ENDIF

	IF	mp$__fescchar eq 1
	$$$_GETCODEESCCHARA char
		IFB	mp$__escchar
	;; Если управляющего символа несуществует
	;; То мы добавляем в строку такое дело
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
		;; Если в строке начавшейся с одинарной ковычки,
		;; встретилась одинарная ковычка, и эта строка не пуста
			IF	mp$__ni eq 1
			EXITM
			ENDIF
		;; Значит строка закончена и мы выводим её
		@CatStr(< db >,%mp$__quote1,%mp$__string,%mp$__quote1)
		mp$__string TEXTEQU	<>
		EXITM
		ENDIF
	ELSEIFIDN	<char>,<">
		IF	mp$__strtype eq 2
		;; Если в строке начавшейся с двойной ковычки,
		;; встретилась двойная ковычка, и эта строка не пуста
		IF	mp$__ni eq 1
		EXITM
		ENDIF
		;; Значит строка закончена и мы выводим её
		@CatStr(< db >,%mp$__quote2,%mp$__string,%mp$__quote2)
		mp$__string TEXTEQU	<>
		EXITM
		ENDIF
	ENDIF
;; Не встретилось ничего интересного?
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
;; Проверяем первый символ строки
	IFIDN	<char>,<'>
	mp$__strtype	=	1
	ELSEIFIDN	<char>,<">
	mp$__strtype	=	2
;;	ELSE
;;.ERR <Ошибка определения строки первый символ обязан быть " или '>
	ENDIF

ELSE	;; Не в первый раз

	IFIDN	<char>,<\>
		IF	mp$__fescchar eq 0
		mp$__fescchar	=	1
		ENDIF
	GOTO ml$__next
	ENDIF

	IF	mp$__fescchar eq 1
	$$$_GETCODEESCCHARW char
		IFB	mp$__escchar
	;; Если управляющего символа несуществует
	;; То мы добавляем в строку такое дело
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
		;; Если в строке начавшейся с одинарной ковычки,
		;; встретилась одинарная ковычка, и эта строка не пуста
			IF	mp$__ni eq 1
			.ERR <Ошибка определения строки:: Вы определили пустую строку ''>
			ENDIF
		;; Значит строка закончена и мы выводим её
		EXITM
		ENDIF
	ELSEIFIDN	<char>,<">
		IF	mp$__strtype eq 2
		;; Если в строке начавшейся с двойной ковычки,
		;; встретилась двойная ковычка, и эта строка не пуста
			IF	mp$__ni eq 1
			.ERR <Ошибка определения строки:: Вы определили пустую строку "">
			ENDIF
		;; Значит строка закончена и мы выводим её
		EXITM
		ENDIF
	ENDIF
;; Не встретилось ничего интересного?
;; Добавляем ещё символ
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
;; Этот макрос производит создание строк
IFDEF	UNICODE_DEF
$$$STRINGW	name,string
ELSE
$$$STRINGA	name,string
ENDIF

				ENDM

;;=========================================================================
$$$ESCSTRING		MACRO	name,string
;; Этот макрос производит создание строк
IFDEF	UNICODE_DEF
$$$ESCSTRINGW	name,string
ELSE
$$$ESCSTRINGA	name,string
ENDIF

				ENDM
;;=========================================================================
$$$ZSTRINGA		MACRO	name,string
;; Этот макрос производит создание строк
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
;; Этот макрос производит создание строк
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
;; Этот макрос производит создание строк
IFDEF	UNICODE_DEF
$$$ZSTRINGW	name,string
ELSE
$$$ZSTRINGA	name,string
ENDIF
			ENDM
;;=========================================================================
$$$ESCZSTRINGA		MACRO	name,string
;; Этот макрос производит создание строк
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
;; Этот макрос производит создание строк
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
;; Этот макрос производит создание строк
IFDEF	UNICODE_DEF
$$$ESCZSTRINGW	name,string
ELSE
$$$ESCZSTRINGA	name,string
ENDIF

				ENDM
;;=========================================================================
;;=========================================================================
;; 			Стековый фрейм
;; 	Макро для определения локальных переменных процедур
;;=========================================================================
;;=========================================================================
$$$STACKFRAME		macro	status,params:VARARG
;; Макрос, который автоматически создаёт фрейм для процедуры
;; npparam - количество параметров процедуры
;; Проверка корректности поля status на корректность использования
;; Проверка происходит без различия регистра букв
IFIDNI	<status>,<BEGIN>
GOTO	ml__begin
ELSEIFIDNI <status>,<END>
GOTO	ml__end
ELSEIFIDNI <status>,<ALIGN>
GOTO	ml__align
ELSE
.ERR <$$$STACKFRAME:неверное значение параметра №1 (status) - \
	должен быть :BEGIN, END или ALIGN>
ENDIF
			: ml__align
IFB <params>
;; Если параметр выравнивания равен 0, значит выравнивания нет
$__stackframe_align = 0
ELSE
$__stackframe_align = params
;; Создаём маску для выравнивания значение esp
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
;; Макро, который определяет определения локальных переменных
;; Проверка корректности поля status на корректность использования
;; Проверка происходит без различия регистра букв
IFIDNI	<status>,<BEGIN>
GOTO	ml__begin
ELSEIFIDNI <status>,<DEL>
GOTO	ml__del
ELSEIFIDNI <status>,<END>
GOTO	ml__end
ELSE
.ERR <$$$LOCAL:неверное значение параметра №1 (status) - \
	должен быть :BEGIN или END>
ENDIF

			: ml__begin
$__stecksize		=	0
$__varcount		=	0
;; Проверим, был ли определён стековый кадр
IF	$__funparam	eq	0
;; Если стекового кадра нет, создаём его
			push 	ebp
			mov	ebp,esp
ENDIF
GOTO ml__macroend
			:ml__del
			add	esp,@CatStr(%$__stecksize)
GOTO ml__macroend			
			:ml__end
;; Выделяем в стеке столько данных сколько указанно
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
;; Макро для поддержки языков
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
