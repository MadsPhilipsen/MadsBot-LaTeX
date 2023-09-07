;----- Funktioner -----
ClipBoardPaste(text, send := "") {	;paster med clipboardet istedet. Har fordele i visse speficike situationer, men er langsomere
	clipSaved := clipboardAll()
	A_Clipboard := text
	send("^v")
	sleep 150	;delay sådan at det paster det rigtige. 
	clipwait		;idk, hjælper måske?
	A_Clipboard := clipSaved
	A_Clipboard := ""
	if send
		send(send)
} PasteFromTxtFile(path) {
	if !FileExist(path) {
		msgbox "Latex Skabalon findes ikke. Lav venligst en " . path . " i mappen hvor dette skript ligger"
		return
	} else {
		text := fileread(path)
		sleep 100
		ClipboardPaste(text)
	}
} getSelected() {
	clipSaved := ClipboardAll()		;for restating it later
	clipText := A_Clipboard			;for testing if it maches
	send("^c")						;update clipboard
	sleep 50 					;sleep. Shits buggy
	var := A_Clipboard
	A_Clipboard := clipSaved			;restore clipboardet
	clipSaved := ""				;slet clipsaved
	return(var)
} pasteAroundSelected(text1, text2, send := "") {
	clipSaved := ClipboardAll()		;for restating it later
	clipText := A_Clipboard			;for testing if it maches
	send("^c")						;update clipboard
	sleep 50 					;sleep. Shits buggy
	paste(text1 . A_Clipboard . text2)	;paste the new thing
	;sleep, 50					;stadig buggy uden????
	A_Clipboard := clipSaved			;restore clipboardet
	A_Clipboard := ""				;slet clipsaved
	if send
		send(send)
	return
} input(titel:="Input") {	;creates inputbox and returns input
	Input := InputBox(titel)
	return(Input)
} 

wolframalpha(text) {
	run("www.wolframalpha.com")	;work in progress. Gad godt kunne paste tekst ind i wolfram alpha søgefeltet
	WinWait("Wolfram|Alpha")
	sleep 500
	paste(text, "{enter}")
} 



;----- Tray handlers -----
TrayGithub(A_ThisMenuItem, A_ThisMenuItemPos, MyMenu)
{ ; V1toV2: Added bracket
Run("`"https://github.com/MadsPhilipsen/MadsBot-LaTeX/tree/main`"")
} ; Added bracket in the end