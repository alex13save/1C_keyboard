#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.14.5
 Author:         Alex Perfilev

 Script Function:
	• Ввод специальных символов в редакторе конфигуратора 1С в русской раскладке клавиатуры
	• Ввод шаблонных конструкций языка 1С

 Горячие клавиши (русская раскладка):

	Alt+н - "Неопределено"
	Alt+з - новый Запрос ...
	Alt+с - "Сообщить"

#ce ----------------------------------------------------------------------------

#include <Misc.au3>

Opt("SendKeyDelay",5) ;10 def

HotKeySet("!н","f001")	; Alt+н - "Неопределено"
HotKeySet("!з","f002")	; Alt+з - новый Запрос
HotKeySet("!с","f003")	; Alt+с - "Сообщить"

While 1
	Sleep(10)
WEnd

Func f001()
	Sleep(250)
	_SendEx("Неопределено")
EndFunc

Func f002()

	Sleep(250) ;т.к. исп Alt+<символ> нужно делать задержу иначе может сгработать главное меню активного приложения

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
