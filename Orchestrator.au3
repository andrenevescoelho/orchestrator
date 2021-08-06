#include <Process.au3>
#include <File.au3>
#include <MsgBoxConstants.au3>
#include <array.au3>

$i = 2
$y = 0

$date = @YEAR&@MON&@MDAY
$date2 = @MDAY&'/'&@MON&'/'&@YEAR&' '&@HOUR&':'&@MIN&':'&@SEC

$log = 'Orquestrador'&$date&'.log'
$date2 = @MDAY&'/'&@MON&'/'&@YEAR&' '&@HOUR&':'&@MIN&':'&@SEC
FileWriteLine($log,$date2&" Iniciando ..." & @CRLF)


While 1
   $ini = FileOpen("contrab.ini",0)
   $line = FileReadLine($ini,$i)

   if $line = 'END' Then
	  $i = 1
   EndIf

if $line <> 'END' then
   $array = StringSplit($line," ")

$ss = $array[1]
$ss = $ss * 1000
$ativo = $array[2]
$script = $array[3]

$Sistema_Minuto = @MIN
$Sistema_hora = @HOUR
$Sistema_dia = @MDAY

   if $ss <> '*' then
   ShellExecute($script)

   $date2 = @MDAY&'/'&@MON&'/'&@YEAR&' '&@HOUR&':'&@MIN&':'&@SEC
   FileWriteLine($log,$date2&" Executando "&$script & @CRLF)
	  While 1
			Sleep(1000)
			if ProcessExists($script) Then
			   $info = _ProcessStatus($script)
			   if $info > 1500 then
				  ProcessClose($script)
				  ExitLoop
			   EndIf
			   ConsoleWrite($info&@CRLF)
			Else
			   ExitLoop
			EndIf
			Sleep($ss)
	  WEnd
   EndIf

EndIf

   FileClose($ini)
   $i = $i + 1
WEnd


Func _ProcessStatus($process)
$aMemory = ProcessGetStats($process,1)

If IsArray($aMemory) Then
   Return($aMemory[2])
   Else
	  ConsoleWrite("An error occurred."&@CRLF)
   EndIf
EndFunc
