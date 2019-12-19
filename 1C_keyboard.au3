#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=1C_keyboard_256x256.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Alex Perfilev

 Script Version: 1.0.0.2

 Script Function:

	• Ввод специальных символов в редакторе конфигуратора 1С в русской раскладке клавиатуры
	• Ввод шаблонных конструкций языка 1С

 Горячие клавиши (русская раскладка):

	Alt+н - "Неопределено"
	Alt+з - новый Запрос ...
	Alt+с - "Сообщить()"
	Alt+д - "Для каждого..."
	Alt+в - "Возврат"

	Alt+3 - "#"
	Alt+7 - "&"
	Alt+\ - "|"
	Alt+х - "["
	Alt+ъ - "]"
	Alt+э - "'"
	Alt+б - "<"
	Alt+ю - ">"
	Alt+ё - "~"

#ce ----------------------------------------------------------------------------

#include <Misc.au3>

Opt("SendKeyDelay",5) ;10 def

HotKeySet("!н","f001")	; Alt+н - "Неопределено"
HotKeySet("!з","f002")	; Alt+з - новый Запрос...
HotKeySet("!с","f003")	; Alt+с - "Сообщить()"
HotKeySet("!д","f004")	; Alt+д - "Для каждого..."
HotKeySet("!в","f005")	; Alt+в - "Возврат"

HotKeySet("!3","f006")	; Alt+3 - "#"
HotKeySet("!7","f007")	; Alt+7 - "&"
HotKeySet("!\","f008")	; Alt+\ - "|"
HotKeySet("!х","f009")	; Alt+х - "["
HotKeySet("!ъ","f010")	; Alt+ъ - "]"
HotKeySet("!э","f011")	; Alt+э - "'"
HotKeySet("!б","f012")	; Alt+б - "<"
HotKeySet("!ю","f013")	; Alt+ю - ">"
HotKeySet("!ё","f014")	; Alt+ё - "~"

While 1
	Sleep(10)
WEnd

Func f001()
	Sleep(250)
	_SendEx("Неопределено")
EndFunc

Func f002()

	Sleep(250) ;т.к. исп Alt+<символ> нужно делать задержу иначе может сработать главное меню активного приложения

	Send("Запрос = Новый Запрос;" & @CRLF)
	Send("Запрос.Текст = """";" & @CRLF & @CRLF)
	Send("Запрос.УстановитьПараметр("""",);" & @CRLF & @CRLF)
	Send("Результат = Запрос.Выполнить();" & @CRLF)
	Send("Если НЕ Результат.Пустой() Тогда" & @CRLF)
	Send("Выборка = Результат.Выбрать();" & @CRLF)
  	Send("Пока Выборка.Следующий() Цикл" & @CRLF)
 	Send(@CRLF & "{BACKSPACE}")
 	Send("КонецЦикла;" & @CRLF & "{BACKSPACE}")
 	Send("КонецЕсли;" & @CRLF)
	Send("{UP 11}{END}{LEFT 2}")

EndFunc

Func f003()
	Sleep(250)
	_SendEx("Сообщить("""");")
	Send("{LEFT 3}")
EndFunc

Func f004()
	Sleep(250)
	Send("Для каждого Стр Из  Цикл" & @CRLF & @CRLF)
	Send("{LEFT}" & "КонецЦикла;")
	Send("{UP 2}{END}{LEFT 5}")
EndFunc

Func f005()
	Sleep(250)
	_SendEx("Возврат")
EndFunc

Func f006()
	Sleep(250)
	_SendEx("#")
EndFunc

Func f007()
	Sleep(250)
	_SendEx("&")
EndFunc

Func f008()
	Sleep(250)
	_SendEx("|")
EndFunc

Func f009()
	Sleep(250)
	_SendEx("[")
EndFunc

Func f010()
	Sleep(250)
	_SendEx("]")
EndFunc

Func f011()
	Sleep(250)
	_SendEx("'")
EndFunc

Func f012()
	Sleep(250)
	_SendEx("<")
EndFunc

Func f013()
	Sleep(250)
	_SendEx(">")
EndFunc

Func f014()
	Sleep(250)
	_SendEx("~")
EndFunc


; --------------------------------------------------------------

;Автор: CreatoR
;Интерпритация на функцию Send(), только с использованием б.обмена - обход проблемы с кодировками
Func _SendEx($sString)
Local $sOld_Clip = ClipGet()

ClipPut($sString)
Sleep(10)
Send("+{INSERT}")

ClipPut($sOld_Clip)
EndFunc

;Автор: CreatoR
;Обход проблемы с отправкой нажатии клавиш в русской раскладке клавиатуры
Func _SendExEx($sKeys, $iFlag=0)
If @KBLayout = 0419 Then
Local $sANSI_Chars = "ёйцукенгшщзхъфывапролджэячсмитьбю.?"
Local $sASCII_Chars = "`qwertyuiop[]asdfghjkl;'zxcvbnm,./&"

Local $aSplit_Keys = StringSplit($sKeys, "")
Local $sKey
$sKeys = ""

For $i = 1 To $aSplit_Keys[0]
$sKey = StringMid($sANSI_Chars, StringInStr($sASCII_Chars, $aSplit_Keys[$i]), 1)

If $sKey <> "" Then
$sKeys &= $sKey
Else
$sKeys &= $aSplit_Keys[$i]
EndIf
Next
EndIf

Return Send($sKeys, $iFlag)
EndFunc
