#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>
#include <WinAPIShPath.au3>
#include <File.au3>

Global $SAPLogon740 = "SAP Logon 740"
Global $SAPLogonExePath = "C:\Program Files (x86)\SAP\FrontEnd\SAPgui\saplogon.exe"
Global $filePath = $CmdLine[1]

main()

Func main()
	Local $SAPLogonPID = startSAPLogon()
	WinWaitActive($SAPLogon740)

	Local $fileContent = readLinesFromFile($filePath)

	If $fileContent == False Then
		$pressedButtonId = MsgBox($MB_SYSTEMMODAL, "Read File Error", "There was an error while reading the file " & $filePath & ". Check if the path is right.")
		While $pressedButtonId <> 1
		WEnd
		closeSAPLogon($SAPLogonPID)
		Exit(1)
	EndIf

	For $number in $fileContent
		ControlSetText("SAP Logon 740","","Edit1",$number)
		Sleep(4000)
	Next

	closeSAPLogon($SAPLogonPID)
EndFunc   ;==>main

Func readLinesFromFile(Const $filePath)
	Local $fileOpen = FileOpen($filePath, $FO_READ)
	If $fileOpen == -1 Then
        Return False
    Else
		Local $numberOfLinesInFile = _FileCountLines($filePath)
		Local $fileLines[$numberOfLinesInFile]
		For $i = 0 to ($numberOfLinesInFile - 1)
			$fileLines[$i] = FileReadLine($fileOpen, $i + 1)
		Next
		Return $fileLines
	EndIf
EndFunc   ;==>readLinesFromFile

Func startSAPLogon()
	Return Run($SAPLogonExePath)
EndFunc   ;==>startSAPLogon

Func closeSAPLogon(Const $SAPLogonPID)
	ProcessClose($SAPLogonPID)
EndFunc   ;==>closeSAPLogon