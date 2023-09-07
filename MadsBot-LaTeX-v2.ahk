#requires AutoHotkey v2
#SingleInstance Force	;force skips dialog box and replaces old instance
SetWorkingDir(A_ScriptDir)
#InputLevel 10			;Important: Gives ^å priority to map to \ so it can activate hotstrings with \
#Include Functions.ahk
#Include QuickMenu.ahk

;Menu, Tray, Icon, Resources\icon.ico
A_TrayMenu.Add()  						;Creates a separator line.
A_TrayMenu.Add("Github", TrayGithub) 	;Creates a new menu item.
;Tray.Add("Help", TrayGithub) ; Creates a new menu item.


/* ;right shift right control to toggle all macros and hotstrings
Madsbot_LaTeX_blocker := 0
;>^>+esc::msgbox("Madsbot LaTeX blocker is now set to " . Madsbot_LaTeX_blocker := f => !Madsbot_LaTeX_blocker)	;It's negated because of ahk jank reasons
>^>+esc::Madsbot_LaTeX_blocker := 1	;It's negated because of ahk jank reasons
#HotIf !Madsbot_LaTeX_blocker	;hvis ikke blockeren er slået til,
HotIf !Madsbot_LaTeX_blocker	 */

;----- Greek Layer -----
;Greec letters with altgr. Shift to capital greek letters
greekMapping := Map("+a","Α","a","α","+b","Β","b","β","+g","Γ","g","γ","+d","Δ","d","δ","+e","Ε","e","ε","+z",
"Ζ","z","ζ","+h","Η","h","η","+t","Θ","t","θ","+i","Ι","i","ι","+k","Κ","k","κ","+l","Λ","l","λ","+m","Μ",
"m","μ","+n","Ν","n","ν","+x","Ξ","x","ξ","+o","Ο","o","ο","+p","Π","p","π","+r","Ρ","r","ρ","+s","Σ","s",
"σ","+u","Τ","u","τ","+y","Υ","y","υ","+f","Φ","f","φ","+c","Χ","c","χ","+v","Ψ","v","ψ","+w","Ω","w","ω")
for key, val in greekMapping 
	Hotkey("<^>!" . key, pasteText.Bind(val))


;----- Arrow layers -----
ArrowMapping := Map("<^>!right", "⟹", "<^>!left", "⟸", "<^>!up", "⟺", "<^>!down", "⇏", 	;alt gr
">^>+right", "→",  ">^>+left", "←", ">^>+up", "↑", ">^>+down", "↓",							;right control right shift
">^<+right", "↦", ">^<+left", "↤", ">^<+up", "∧", ">^<+down", "∨",						   ;right control left shift
"<+>+right", "⊂", "<+>+left", "⊃", "<+>+up", "∩", "<+>+down", "∪")						   	;both shift keys
for key, val in ArrowMapping
	Hotkey(key, pasteText.Bind(val))

;----- Main Symbol Layer -----
;Math symbols with right control right shift. Unused: abhjklmuwyæå123456790+<,.-
SymbolMapping := Map("r", "ℝ", "q", "ℚ", "z", "ℤ", "n", "ℕ", "c", "ℂ", "a", "א‎", "v", "∀", "e", "∃", "p", "∈", "s", "⊆", 
"f", "¬", "x", "×", "k", "∘", "o", "⊗", "i", "∫", "d", "∂", "l", "ℓ", "g", "∇", "8", "∞", "ø", "∅")
for key, val in SymbolMapping
	Hotkey(">^>+" . key, pasteText.Bind(val))
>^>+t::paste("\{\}", "{left 2}")	;t set manually because it uses to parameters

;----- Alt Symbol Layer -----
;More symbols with right control left shift. Unused: bdfhjqwyzæøå345,-
>^<+a::SelectionMenu(["←","→","↔","↤","↦","⟵","⟶","⟷","⟻","⟼","↚","↛","↮","⇜","⇝","↭","⇷","⇸","⇹","⬳","⟿","⬸","⤑","⬰","⇴","⥈","⬾","⥇","⬲","⟴","⇇","⇉","⇆","⇄","⬱","⇶"],"Pile") ;https://latex-tutorial.com/arrow-latex/
>^<+c::SelectionMenu(["sin(","cos(","tan(","arcsin(","arccos(","arctan(","cosh(","sinh(","tanh(","arsinh(","arcosh(","artanh("], "trigonometriske funktioner")
>^<+e::SelectionMenu(["∃","∀","∄"], "Kvator symboler")
>^<+g::selectionMenu(greekMapping, "Greek keybinds. '+' = shift", 24, "w30")
>^<+h::helpMenu()
>^<+i::SelectionMenu(["∫","∬","∭","⨌","∮","∯","∰","⨍","⨎","⨏","⨐","∱","⨑","∲","∳","⨒","⨓","⨔","⨕","⨖","⨗","⨘","⨙","⨚","⨛","⨜","⨋","⌠","⌡"], "Integral symboler")
>^<+k::SelectionMenu(["●","◖","◗","■","◆","▰","▲","◀","▶","◢","◣","◤","◥","○","□","◇","▱","△","◁","▷","◿","◺","◸","◹","◐","◑","◒","◓","◔","◕","◧","◨","◩","◪","◫","◭","◮","◰","◱","◲","◳","◴","◵","◶","◷"],"kanter")
>^<+l::SelectionMenu(["∧","∨","⟹","⟸"],"logik symboler")
>^<+m::SelectionMenu(["⟹","⟸","⟺","⟾","⟽","⇒","⇐","⇑","⇓","⇔","⇕","⇏","⇍","⇎","⤂","⤃","⤄","⤇","⤆","⇗","⇘","⇙","⇖","⇛","⇚","⤊","⤋","⭆","⭅","⟰","⟱"], "Medføre pile")
>^<+n::send("ℕ_0")
>^<+o::SelectionMenu(["⊕","⊖","⊗","⊘","⊙","⊚","⊛","⊝","○","◌","◍","◎","◉","⨶","⨷","⨸","⌀","ø","∅","◦","°","○"],"Cirkel symboler")
>^<+p::SelectionMenu(["∈","∉","∋","∌","∊","∍"], "Part symboler")
>^<+r::SelectionMenu(["ℝ","ℝ^2","ℝ^3","ℝ^4","ℝ^5","ℝ^6","ℝ^7","ℝ^8","ℝ^9","ℝ_-","ℝ_+","ℝ\backslash\{0\}","ℝ^n"], "Reele tal variationer")
>^<+s::SelectionMenu(["⊂","⊃","⊆","⊇","⊄","⊅","⊈","⊉", "⊊", "⊋", "⋐","⋑"], "Delmængde symboler")	;delmængde menu
>^<+t::✓	;tjekmark
>^<+u::SelectionMenu(["∞","⧜","⧝","⧞","♾","ℵ"], "Den uendelige liste")
>^<+v::SelectionMenu(["⊥","⊢","⊣","⊤"], "Vinkel symboler")
>^<+x::SelectionMenu(["⋅","×","÷","∏","⊗"], "Gange symboler")
>^<+1::SelectionMenu(["|","∣","⟊","∤","⫮","∥","∦","⫲","⫳","⋕","⫽","⦀","⫵","⫻"], "lodrette streger")
>^<+2::SelectionMenu(["^","⁰","¹","²","³","⁴","⁵","⁶","⁷","⁸","⁹","⁺","⁻","⁼","⁽","⁾","√","∛","∜"],"Potenser menu")
>^<+7::SelectionMenu(["()","[]","{}","⌊⌋","⌈⌉","⟨⟩"], "Parantes sæt")
>^<+8::SelectionMenu(["(","[","{","⌊","⌈","⟨"], "Start parenteser")
>^<+9::SelectionMenu([")","]","}","⌋","⌉","⟩"], "Slut parenteser")
>^<+0::SelectionMenu(["=","≠","∼","∽","≈","≂","≃","⋍","≄","≅","≌","≆","≇","≉","≊","≋","≍","≎","≏","≐","≑","≒","≓","≔","≕","≖","≗","≙","≚","≜","≟","≡","≢","≭","⋕"], "Ligmed symboler")
>^<++::SelectionMenu(["+","±","∓","⩱","⩲","∑","⨊","⨋","⨁","⊞","⨹","⧺","⧻","⎲","⎳"], "Plus menu")
>^<+<::SelectionMenu(["≤","≥","≦","≧","≨","≩","≪","≫","≮","≯","≰","≱","≲","≳","≴","≵","≶","≷","≸","≹","≺","≻","≼","≽","≾","≿","⊀","⊁","⊰","⋖","⋗","⋘","⋙","⋚","⋛","⋞","⋟","⋠","⋡","⋦","⋧","⋨","⋩"], "Uligheds symboler", 22)
>^<+.::SelectionMenu(["⋯","⋱","⋮","⋰","⋅","∶","∴","∵","∷","⦁","●"], "Prikker")

;----- Shorthand Hotstrings -----
;type first, get second
HotstringMapping := Map("<=", "≤", ">=", "≥", "/<", "≮", "/>", "≯", "</=", "≰", ">/=", "≱ ", "=ish", "≈", "/=", "≠", "~=", "≃",
 "sinx", "sin(x)", "siny", "sin(y)", "sint", "sin(t)", "sin2", "sin^2", "sinhx", "sinh(x)", "sinhy", "sinh(y)", "sinht", "sinh(t)", 
 "cosx", "cos(x)", "cosy", "cos(y)", "cost", "cos(t)", "cos2", "cos^2", "coshx", "cosh(x)", "coshy", "cosh(y)", "cosht", "cosh(t)", 
 "tanx", "tan(x)", "tany", "tan(y)", "tan2", "tan^2", "tanhx", "tanh(x)", "tanhy", "tanh(y)", "logx", "log(x)", "logn", "log(n)", 
 "fx", "f(x)", "gx", "g(x)", "...1", "⋯", "...2", "⋱", "...3", "⋮")
for str, val in HotstringMapping
	Hotstring(":*?:" . str, val)

;----- Heading Hotstrings -----
headingsMapping := Map("\dato", ["\section*{" . FormatTime(,"dd/MM/yyyy") . "}", "{left}"], 
"\def", ["\subsubsection*{Definition }", "{left}"], "\sæt", ["\subsubsection*{Sætning }", "{left}"], "\kor", ["\subsubsection*{Korollar }", "{left}"], 
"\lem", ["\subsubsection*{Lemma }", "{left}"], "\eks", ["\subsubsection*{Eksempel }", "{left}"], "\bem", ["\subsubsection*{Bemærk}", ""], 
"\opg", ["\subsection*{Opgaver}", ""], "\prop", ["\subsubsection*{Proposition}", ""], "\cor", ["\subsubsection*{Corollary  }", "{left}"], 
"\ex", ["\subsubsection*{Example }", "{left}"], "\rem", ["\subsubsection*{Remark }", "{left}"])
for str, val in headingsMapping
	Hotstring(":*?:" . str, paste.Bind(val[1], val[2]))
;Heading macros	with left control + alt + number keys
for key, val in Map("1", ["\section*{}","{left}"], "2", ["\subsection*{}", "{left}"], "3", ["\subsubsection*{}","{left}"], "4", ["\paragraph{}","{left}"])
	Hotkey("<!<^" . key, paste.Bind(val[1], val[2]))

;----- \ Hotstrings that calls functions -----
:*?X:\skabalon::PasteFromTxtFile("Data\LaTeX_skabalon.txt")
:*?X:\forside::PasteFromTxtFile("Data\LaTeX_forside.txt")
:*?X:\footer::PasteFromTxtFile("Data\LaTeX_footer.txt")


;----- Alt Layer -----
;Alt + key = quick menu. Alt + left control + key = paste raw text. Alt + shift + key = paste around selected text
;--- m = matrix -----
;m::paste("matrix dimmer")
!m::pastemenu(matrixMenu("Matrix Menu", "matrix"))
;<+<!m::matrix around selected
;--- s = sum ---
<^<!s::paste("∑_{i=1}^{n}{}", "{left 1}")	
<!s::pasteQuickMenu("Sum fra [1] til [2] over [3]", ["∑_{", "}^{", "}{", "}"], "sum")		
<+<!s::pasteQuickMenu("Sum fra [1] til [2] af markeret", ["∑_{", "}^{", "}{" . getSelected() . "}"])
;--- d = division ---
<!<^d::paste("\frac{}{}", "{left 3}")
<!d::pasteQuickMenu("Brøk: [1] divideret med [2]", ["\frac{", "}{", "}"], "brøkker")	
<!<+d::pasteAroundSelected("\frac{", "}{}", "{left}")
;--- i = integra ---
<^<!i::paste("∫_{a}^{b}{}", "{left 1}")
<!i::pasteQuickMenu("Integral fra [1] til [2] af [3]", ["∫_{", "}^{", "}{", "}"], "integral")
;<+<!i::pasteQuickMenu("Integral fra [1] til [2] af markeret", "∫_{", "}^{", "}{" . getSelected() . "}")
;--- j = solve integral ---
<^<!j::paste("[]_{}^{}", "{left 7}")
<!j::pasteQuickMenu("Løsning af integral: [[3]]_[1]^[2]", ["[", "]_{", "}^{", "}"], "integral")		;Uses the integral savesection to load them easier
;<+<!j::pasteQuickMenu("Løsning af integral: Markeret fra [1] til [2]", "[" . getSelected() . "]_{", "}^{", "}")
;--- l = limit ---
<^<!l::paste("\lim_{n→∞}{}", "{left}")
<!l::pasteQuickMenu("Grænseværdi for [1] gående mod [2] af [3]", ["\lim_{", "→", "}{", "}"], "grænseværdi")
<+<!l::pasteQuickMenu("Grænseværdi for [1] gående mod [2] af markeret", ["\lim_{", "→", "}{" . getSelected() . "}"])
<!p::pasteQuickMenu("Partielt afledt: Funktion=[1], variabel=[2]", ["\frac{∂", "}{∂", "}"], "partieltAfledt")
;--- k = konjuger ---
<^<!k::paste("\overline{}", "{left}")
<!k::pasteQuickMenu("konjuger [1]", ["\overline{", "}"], "konjugeret")
<+<!k::pasteAroundSelected("\overline{" , "}")
;--- v = vector arrow above ---
<^<!v::paste("\vec{}", "{left}")
<!v::pasteQuickMenu("Vector pil over [1]", ["\vec{", "}"], "vectorpil")
<!<+v::pasteAroundSelected("\vec{","}")
;--- h = hat ---
<^<!h::paste("\widehat{}", "{left}")
<!h::pasteQuickMenu("hat over [1]", ["\widehat{", "}"], "hat")
<!<+h::pasteAroundSelected("\widehat{","}")
;--- o = text over ---
<^<!o::paste("\overset{}{}", "{left 3}")
<!o::pasteQuickMenu("[1] over [2]", ["\overset{", "}{", "}"], "over")
<!<+o::pasteQuickMenu("over markeret", "\overset{", "}{" . getSelected() . "}")
;--- u = text under ---
<^<!u::paste("\underset{}{}","{left 3}")
<!u::pasteQuickMenu("[2] under [1]", ["\underset{", "}{", "}"], "under")
<+<!u::pasteQuickMenu("over markeret", "\underset{", "}{" . getSelected() . "}")	
;--- t = tekst ---
<^<!t::paste("\text{}", "{left}")
<!t::pasteQuickMenu("[1] som tekst", ["\text{", "}"], "text")
<+<!t::pasteAroundSelected("\text{", "}")
;--- b = \mathbb ---
<^<!b::paste("\mathbb{}", "{left}")
<!b::pasteQuickMenu("[1] som mathbb tekst, f.eks ℝ", ["\mathbb{", "}"], "mathbb")
<+<!b::pasteAroundSelected("\mathbb{", "}")
;--- c = cases ---
<^<!c::paste("\begin{cases}\end{cases}", "{left 11}{enter 2}{left}")
<!c::paste("\begin{cases}\end{cases}", "{left 11}{enter 2}{left}")
<+<!c::selected := getSelected(), paste("\begin{cases}" . selected . "\end{cases}", "{left " . 11+StrLen(selected) . "}{enter}{right " . StrLen(selected) . "}\\{enter 2}{left}")
;- w = wolframalpha -
<^<!w::run("www.wolframalpha.com")
<!w::wolframalpha(menuResult(quickmenu("Wolfram Alpha search")))
<+<!w::wolframalpha(StrReplace(getSelected(), "$"))	;removes $'s from equations
;--- 1 = inverse --- ("<!<^" claimed by quicksection for n∈[1,4]∈Ν)
<!1::paste("^{-1}")
<!<+1::pasteAroundSelected("\frac{1}{","}")
;--- 2 = squareroot ---
<!2::paste("\sqrt{}", "{left}")
<!<+2::pasteAroundSelected("\sqrt{","}")
;--- 3 = n root ---
<!3::pasteQuickMenu("[1]'te rod af [2]",["\sqrt[", "]{", "}"], "nroot")
<!<+3::pasteQuickMenu("[1]'te rod af markeret'",["\sqrt[", "]{" . getSelected() . "}"])
;--- other alt stuff ---
<!0::paste("\{0\}")							;singleton 0
<!<::paste("⌊⌋", "{left}")					;floor
<!<+<::paste("⌊" . getSelected() , "⌋")		;floor around
<!<^<::paste("⌈⌉", "{left}")				;celling
<!<+<^<::paste("⌈" . getSelected() , "⌉")	;celling around

;----- Navigation -----
;--- start matematik felter ---
<!æ::paste("$")							;alt æ til ligning i linje (virker i overleaf)
<!ø::paste("\begin{equation}\end{equation}", "{left 14}{enter 2}{left}")					;alt ø til ligning i linje (virker i obsidian)
+^æ::pasteAroundSelected("$", "$")		;sætter $ omkring markeret
+^ø::pasteAroundSelected("\begin{equation}", "\end{equation}")	;sætter $$ omkring markeret
<!'::paste("\begin{align}\end{align}", "{left 11}{enter 2}{left}")	;alt ' til align ligning
<!<+'::pasteAroundSelected("\begin{align}","\end{align}")
<!space::pasteQuickMenu("Hurtig ligning: $[1]$", ["$","$"], "ligninger")
;--- mellemrum i matematik felter ---
<^>!space::paste("\ ")					;lave rigtige mellemrum i matematik felt
>^space::paste("\quad ")					;laver næst størst mellemrum i mateamtik felt
<^>!>^space::paste("\qquad ")				;laver størst mellemrum i matematik felt
<^>!,::paste(",\ ")						;Laver comma i matematik felt med efterfulgt af mellemrum
>^,::paste(",\quad ")					;laver comma+næst størst mellemrum i mateamtik felt
<^>!>^,::paste(",\qquad ")				;laver comma+størst mellemrum i matematik felt
<^space::send("{end}{space}")				;mellemrum til sidst i linjen
;--- enters i LaTeX ---
<^>!enter::paste("\\","{enter}")			;Ordenligt nylinje i latex
;<^>!>^enter::send({end}\\{enter})			;Forlad linje med \\
;--- andet ---
;<^>!.::send {end}.\\{enter}	;punktum til sids<t på linje, ny linje
>+-::paste("_{}","{left}")				;højreshift minus = subscrit med tuborg klap


;----- Other hotkeys -----
^ø::⋅		;fancy gangetegn (altså en prik)
^æ::⋅		;fancy gangetegn (altså en prik)


;----- Experimental macros -----
;Subject to change
<+>+i::paste("_{i∈I}")
<+>+3::paste("\#")

<^<!f::paste("∪_{n∈ℕ}{}", "{left}")
<!f::pasteQuickMenu("Forenings fra [1] til [2] af [3]", ["∪_{", "}^{", "}{", "}"], "foreningsmængde")
<!<+f::pasteQuickMenu("Forenings fra [1] til [2] af markeret", ["∪_{", "}^{", "}{" . getSelected() . "}"])
;<!<+f::pasteAroundSelected("∪_{", "}^{", "}")
<^<!g::paste("∩_{n∈ℕ}{}", "{left}")
<!g::pasteQuickMenu("Fællesmængde fra [1] til [2] af [3]", ["∩_{", "}^{", "}{", "}"], "fællesmængde")
<!<+g::pasteQuickMenu("Fællesmængde fra [1] til [2] af markeret", ["∪_{", "}^{", "}{" . getSelected() . "}"])