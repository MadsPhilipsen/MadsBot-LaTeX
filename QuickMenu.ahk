menuResult(menu) {
    while !menu.result  ;waits until the menu has a result
        sleep 10        ;checks 100 times a second. Efficient? Probably not. But i dont want to wait, or make the code more compleks by making a direct paste flag in the menu object. 
    result := menu.result, menu.__Delete()
    if result = "ERROR: FORCED CLOSED" 
        exit        ;exit thread so menu closes without pasting anything
    return result
} paste(text, keys := "", *) {	; has a second optional argument for any text to send. 
	sendinput("{text}" . text)
	if keys
		send(keys)
} pasteText(text*) {        ;is varadic so it can be called from funcobjects in hotkeys without caussing an error
    paste(text[1])
} pastemenu(menu) {         ;just makes the code more readable. 
    paste(menuResult(menu))
} pasteQuickMenu(title, format, savesection := "") {
    result := menuResult(quickmenu(title, savesection))
    strings := StrSplit(result, " ",, format.Length-1)
    loop format.length-strings.Length       ;makes stringsarray as long as format array to prevent error
        strings.Push("")
    text := ""
    for i, str in format {
        text .= str . strings[i]
    }
    paste(text)
}


class helpMenu extends menuBase {
    __New() {
        global
        this.gui := Gui(,"Hjælp"), this.gui.Opt("+AlwaysOnTop -SysMenu +Owner"), this.gui.MarginX := this.gui.MarginY := 0
        this.gui.add("Button", "x0 y+0", "Græsk med altgr").OnEvent("Click",ObjBindMethod(this, "OpenMenu", selectionMenu, [greekMapping, "Græsk shortcuts: '+' = shift", 24, "w30"]))
        this.gui.add("Button", "x0 y+0 r2", "Matematiske symboler`nmed højrekontrol højreshift").OnEvent("Click",ObjBindMethod(this, "OpenMenu", selectionMenu, [SymbolMapping, "Matematiksike symboler shortcuts: Brug altid højre kontrol højre shift",, "w30"]))
        this.gui.add("Button", "x0 y+0", "Pile taster funktioner").OnEvent("Click",ObjBindMethod(this, "OpenMenu", selectionMenu, [ArrowMapping, "Pile taster: <^>! = altgr, >^>+ = højrekontrol højreshift, >^<+ = højrekontrol venstreshift, <+>+ = begge shift",, "w30"]))
        this.gui.add("Button", "x0 y+0", "Praktiske Hotstrings").OnEvent("Click",ObjBindMethod(this, "OpenMenu", selectionMenu, [HotstringMapping, "Pile taster: <^>! = altgr, >^>+ = højrekontrol højreshift, >^<+ = højrekontrol venstreshift, <+>+ = begge shift", 24, "w30"]))
        ;this.gui.add("Button", "x0 y+0", "LaTeX Headings hotstrings").OnEvent("Click",ObjBindMethod(this, "OpenMenu", selectionMenu, [headingsMapping, "Pile taster: <^>! = altgr, >^>+ = højrekontrol højreshift, >^<+ = højrekontrol venstreshift, <+>+ = begge shift", 24, "w30"]))

        this.otherstartstuff()
    }

    OpenMenu(menu, params*) {
        menu(params[1]*)
    }
}


class selectionMenu extends menubase {
    ;List made with https://onlinetexttools.com/split-text
    keys := ["1","2","3","4","5","6","7","8","9","0","q","w","e","r","t","y","u","i","o","p","a","s","d","f","g","h","j","k","l","z","x","c","v","b","n","m",",",".","-","^1","^2","^3",
    "^4","^5","^6","^7","^8","^9","^0","^q","^w","^e","^r","^t","^y","^u","^i","^o","^p","^a","^s","^d","^f","^g","^h","^j","^k","^l","^z","^x","^c","^v","^b","^n","^m","^,","^.","^-"]

    __New(list, title, newlineAfter := "", buttonOptions := "", textOptions := "") {
        this.mapping := Map()
        if Type(list) = "Map" {
            this.mapping := list
        } else if Type(list) = "Array" {
            for i, str in list 
                this.mapping.set(this.keys[i], str)
        } else {
            return
        }
        
        this.gui := Gui(,title), this.gui.Opt("+AlwaysOnTop -SysMenu +Owner"), this.gui.MarginX := this.gui.MarginY := 0

        HotIfWinactive("ahk_id " . this.gui.hwnd) 
        xcoord := 0, ycoord := 0
        for key, str in this.mapping {
            this.gui.SetFont("s16")
            this.gui.add("Button", "x" xcoord  " y" ycoord " h32 " buttonOptions, str).OnEvent("Click",ObjBindMethod(this, "paste", str))
            this.gui.SetFont("s12")
            this.gui.add("Text", "xp y+0 wp center " textOptions, key)
            
            try Hotkey(key, ObjBindMethod(this, "paste", str))  ;Is try so it can display hotstrings

            xcoord := "+0", ycoord := "p-32"                    ;resets to be default
            if newlineAfter and Mod(A_Index, newlineAfter) = 0  ;only when afternewline has been set and
                xcoord := "0", ycoord := "+0"                   ;are they made to make a new line
        }
        this.otherstartstuff()
    }

    paste(string, params*) {    ;params* makes it take more unused parameters. Needed when calling from as a boundfunctionobject from hotkey
        this.__Delete()         ;closes menu
        paste(string)           ;pastes string
    }
}


class matrixMenu extends menubase {
    matrixformats := [["( )", "\begin{pmatrix}`n", "&", "\\`n", "`n\end{pmatrix}"]
    , ["[ ]", "\begin{bmatrix}`n", "&", "\\`n", "`n\end{bmatrix}"]
    , ["{ }", "\begin{Bmatrix}`n", "&", "\\`n", "`n\end{Bmatrix}"]
    , ["ǀ ǀ", "\begin{vmatrix}`n", "&", "\\`n", "`n\end{vmatrix}"]
    , ["‖ ‖", "\begin{Vmatrix}`n", "&", "\\`n", "`n\end{Vmatrix}"]
    , ["Ø", "\begin{matrix}`n", "&", "\\`n", "`n\end{matrix}"]
    , ["ary", "\left(\begin{array}{}`n", "&", "\\`n", "\end{array}\right)"]
    , ["wα", "{{" , "," , "},{", "}}"]
    , ["🍁", "<<", "|", ">,<", ">>"]]

    __New(title, savesection := "") {
        this.gui := Gui(,title), this.gui.Opt("+AlwaysOnTop -SysMenu +Owner"), this.gui.MarginX := this.gui.MarginY := 0
        this.gui.SetFont("s20")
        this.gui.edit := this.gui.Add("Edit","x0 y0 w300 r8 vEdit"), ControlFocus(this.gui.edit.hwnd)
        this.gui.insert := this.gui.Add("Button", "xp y+0 wp-108 h38", "Insert").OnEvent("Click",ObjBindMethod(this, "ctrlenter"))
        this.gui.help := this.gui.Add("Button", "x+0 yp w68 hp", "help").OnEvent("Click", ObjBindMethod(this, "help"))

        this.gui.SetFont("s18")
        this.gui.saveslotselector := this.gui.Add("DropDownList", "x+0 yp w40 hp Choose1", ["1","2","3","4","5","6","7","8","9","10"])
        this.gui.saveSelector := savesection ? this.createListBox(savesection, 10, "x300 y0 w260 r10", "s19", ObjBindMethod(this, "loadMatrix")) : false
        this.gui.formatSelector := this.createListBox(this.formatnames, 10, "x+0 yp w40 r10 Choose1", "s19", "noCall")
        this.otherstartstuff(savesection)
        
        ;creating hotkeys to bind control+number to select that number of slot to save matrice in
        HotIfWinactive("ahk_id " . this.gui.hwnd)   
        hotkey("^1", f => this.gui.saveslotselector.value := 1), hotkey("^2", f => this.gui.saveslotselector.value := 2), hotkey("^3", f => this.gui.saveslotselector.value := 3)
        hotkey("^4", f => this.gui.saveslotselector.value := 4), hotkey("^5", f => this.gui.saveslotselector.value := 5), hotkey("^6", f => this.gui.saveslotselector.value := 6)
        hotkey("^7", f => this.gui.saveslotselector.value := 7), hotkey("^8", f => this.gui.saveslotselector.value := 8), hotkey("^9", f => this.gui.saveslotselector.value := 9)
        hotkey("^0", f => this.gui.saveslotselector.value := 10)
    }
    

    ctrlenter(*) {
        for i, format in this.matrixformats {
            if format[1] = this.gui.formatSelector.text
                choosenFormat := format
        }
        text := this.formatMatrix(this.gui.edit.value, choosenFormat)
        upload := StrReplace(StrReplace(this.gui.edit.value, A_Space, "⠀"),"`n", "→")   ;Converts space to braile space and enter to → so it can be saved to ini without causing problems. 
        this.save(upload, this.gui.saveslotselector.value), this.__Delete()
        this.result := text
    }

    loadMatrix(*) {
        this.gui.edit.value := StrReplace(StrReplace(this.gui.saveSelector.text, "⠀", A_Space),"→", "`n")   ;Converts space to braile space and enter to → so it can be saved to ini without causing problems. 
    }

    formatMatrix(input, format) {
        text := ""
        before := format[2], spaceSeperator := format[3], enterSeperator := format[4], after:= format[5]
        list1 := StrSplit(this.gui.edit.value, "`n")			;enter
        for i, str in list1 {					;for every line
            list2 := StrSplit(str, A_Space)		;space
            for j, v in list2 {					;for every element in line
                if (A_Index != list2.length)	;if not last elemnt in line
                    text .= v . spaceSeperator	;add element and spaceseperator
                else							;if last element in line
                    text .= v					;add element (not spaceseperator)
            }
            if (A_Index != list1.length)		;if it's not he last line
                text .= enterSeperator			;add enterseperator
        }
        return before . text . after
    }


    ctrlup() {
        this.gui.edit.value := this.selectionChange(-1, this.gui.saveSelector)
    } ctrldown() {
        this.gui.edit.value := this.selectionChange(1, this.gui.saveSelector)
    } ctrlleft() {
        this.selectionChange(-1, this.gui.formatSelector)
    } ctrlright() {
        this.selectionChange(1, this.gui.formatSelector)
    }


    help(*) {   ;* makes it take an unlimited amout of unused parameters. Needed when calling from gui.control.onevent()
        MsgBox
            (
            "Skriv matricen ved at sepererer med mellemrum og nyline (enter), som f.eks:
            1 2
            3 4
            Kontrol+enter for at gemme matricen, lukke viduet og paste matricen.
            Kontrol+pilop/pilned for at loade gamle matricer. 
            Kontrol+venstre/højrepil for at vælge matrix formateringen.
            Kontrol+tallet for linjen hvor matricen skal gemmes."
            )
    }

    ;formatnames => this.matrixformats[]
    formatnames  ; Use brackets only when parameters are present.
    {
        get {
            formatnames := Array()
            for format in this.matrixformats {
                formatnames.Push(format[1])
            }
            return formatnames
        }
    }
}

class integralMenu extends menubase {
    __New(title, savesection := "") {
        this.gui := Gui(,title), this.gui.Opt("+AlwaysOnTop -SysMenu +Owner"), this.gui.MarginX := this.gui.MarginY := 0
        this.gui.SetFont("s16")
        this.integralselector := this.gui.add("DropDownList","w45 choose1", ["∫","∬","∭","⨌","∮","∯","∰","⨍","⨎","⨏","⨐","∱","⨑","∲","∳","⨒","⨓","⨔","⨕","⨖","⨗","⨘","⨙","⨚","⨛","⨜","⨋"])
        this.gui.edit := this.gui.Add("Edit","w206 x+0 yp r1 vEdit")
        this.gui.saveSelector := savesection ? this.createListBox(savesection, 10, "x0 y+0 w251 r10") : false ;sætter gui.saveselector hvis savesection er givet
        ControlFocus(this.gui.edit.hwnd)
        this.otherstartstuff(savesection)
    }

    enter() {
        strings := StrSplit(this.gui.edit.value, " ",, 3)
        loop 3-strings.Length   ;if strings is to short
            strings.Push("")    ;make it longer to prevent error
        text := this.integralselector.text . "_{" strings[1] . "}^{" . strings[2] . "}{" . strings[3] . "}"
        this.save(), this.__Delete()
        this.result := text ;setting results returns value in callmenu function. After window closes to not paste in gui      
    } up() {
        this.gui.edit.value := this.selectionChange(-1, this.gui.saveSelector)
    } down() {
        this.gui.edit.value := this.selectionChange(1, this.gui.saveSelector)
    } ctrlup() {
        this.selectionChange(-1, this.integralselector)
    } ctrldown() {
        this.selectionChange(1, this.integralselector)
    }
}

class quickmenu extends menubase {
    keys := ["enter", "up", "down"]
    __New(title, savesection := "") {
        this.gui := Gui(,title), this.gui.Opt("+AlwaysOnTop -SysMenu +Owner"), this.gui.MarginX := this.gui.MarginY := 0
        this.gui.SetFont("s16"), this.gui.edit := this.gui.Add("Edit","w251 r1 vEdit")
        this.gui.saveSelector := savesection ? this.createListBox(savesection, 10, "x0 y+0 wp r10") : false ;sætter gui.saveselector hvis savesection er givet
        this.otherstartstuff(savesection)
    }

    enter() {
        this.save(), this.result := this.gui.edit.value
    } up() {
        this.gui.edit.value := this.selectionChange(-1, this.gui.saveSelector)
    } down() {
        this.gui.edit.value := this.selectionChange(1, this.gui.saveSelector)
    }
}

Class menubase {
    result := ""    ;variable set to false, so it can be used to check and return when the gui is done. 
    iniPath := "Data\savedata.ini"
    otherstartstuff(savesection:="")
    {
        this.savesection := savesection
        ;this.gui.OnEvent("escape", (this) => MenuFromHwnd(this.hwnd).__Delete())    ;makes escape close the window
        this.gui.OnEvent("escape", ObjBindMethod(this, "__Delete"))    ;makes escape close the window

        HotIfWinactive("ahk_id " . this.gui.hwnd)   ;You'd thing the folliwing would be able to be a for loop on an array of keys, right?!
        if HasMethod(this, "enter")                 ;BUT NOOOO it can't. Because of SOMETHING to do with f being reused in the loop. 
            hotkey("enter", f => ObjBindMethod(this, "enter").Call())   ;So somehow, this is the best way of doing things. I want to jump out of a window
        if HasMethod(this, "ctrlenter")             ;Note: Additional hotkeys can be added by adding the hotkey command in the __New method
            hotkey("^enter", f => ObjBindMethod(this, "ctrlenter").Call())
        if HasMethod(this, "up")
            hotkey("up", f => ObjBindMethod(this, "up").Call())
            ;hotkey("up", ObjBindMethod(this, "up").Call())
        if HasMethod(this, "down")
            hotkey("down", f => ObjBindMethod(this, "down").Call())
        if HasMethod(this, "ctrlup")
            hotkey("^up", f => ObjBindMethod(this, "ctrlup").Call())
        if HasMethod(this, "ctrldown")
            hotkey("^down", f => ObjBindMethod(this, "ctrldown").Call())
        if HasMethod(this, "ctrlleft")
            hotkey("^left", f => ObjBindMethod(this, "ctrlleft").Call())
        if HasMethod(this, "ctrlright")
            hotkey("^right", f => ObjBindMethod(this, "ctrlright").Call())
        this.gui.Show()
    }

    selectionChange(n, selector := this.gui.selector) {
        length := ControlGetItems(selector.hwnd, this.gui.hwnd).Length
        val := Mod(selector.Value+n+length,length)
        ;if val<=0       ;mod doens't work for negative numbers for some stupid reason
        ;    val += length
        selector.Choose(val)
        return(selector.text)
    }
    updateSelection(*) {    ;* makes it take an unlimited amout of unused parameters. Needed when calling from gui.control.onevent()
        this.gui.edit.value := this.gui.saveselector.text
    }

    createListBox(loadsection, n, options, fontsize := "s12", onclick := ObjBindMethod(this, "updateSelection")) {
        this.gui.SetFont(fontsize)
        if IsObject(loadsection) {
            list := loadsection
        } else {
            list := Array(), slot := IniRead("Data\savedata.ini", loadsection, "OldSaveSlot", 1)-1          ;defaults to slot 1
            loop n
                list.push(IniRead("Data\savedata.ini", loadsection, mod(n+slot+(A_Index)-1, n)+1, ""))      ;default is blank string. +n in mod because mod doesn't work for negative
        }
        menu := this        ;Tjek om denne er ubrugelig
        selector := this.gui.Add("Listbox", options, list)
        if onclick != "noCall"
            selector.OnEvent("change", onclick)
        return selector
    }

    save(value := this.gui.edit.value, saveslot := "next", savesection := this.savesection, path := this.iniPath, maxslots := 10) {
        if savesection {    ;error catching
            if saveslot = "next" {
                oldsaveslot := IniRead(this.iniPath, this.savesection, "OldSaveSlot")
                if IniRead(path, savesection, oldsaveslot) != value {  ;checks value isnt already in previous slot. Don't want to write the same thing twice
                    saveslot := Mod(oldsaveslot+maxslots-2,maxslots)+1                 ;Gives -1 in mod 10, but never and n∈[1,10]∈ℕ
                    IniWrite(value, path, this.savesection, saveslot)
                    iniwrite(saveslot, path, this.savesection, "OldSaveSlot")
                } return
            } else {
                IniWrite(value, this.iniPath, savesection, saveslot)
            }
        }   
    }

    __Delete(*)
    {
        if HasMethod(this, "otherdeletestuff")
            this.otherdeletestuff()
        this.gui.Destroy() ;closes gui
        this.result := "ERROR: FORCED CLOSED"   ;Makes menuCall realise it was forced close and not return a value, thus not pasting without user inout
    }
}