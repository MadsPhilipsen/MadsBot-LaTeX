#NoEnv  
#Singleinstance Force	;force skips dialog box and replaces old instance
SetWorkingDir %A_ScriptDir%
#InputLevel 10			;super vigigt. Gør at ^å som mapper til \ kan aktivere andre makroer

/*	Madsbot LaTeX af Mads Philipsen
	
	Altgr=græske bogstaver
	Altgr+shift=store græske bogstaver
	Altgr+piletaster (evt + højre eller venstreshift)=medførepile
	højrekontrol+højreshift=matematik symboler
	højrekontrol+venstreshift=alternative matematiksymboler
	højrekontrol+piletaster (evt + højre eller venstreshift)=pile og pile agtige symboler
	Alt=komplicerede makroer der paster tekststrenge og eller åbner menuer 
	Bonus:
	\hotstrings til sektioner
	Hotstrings til diverse tekst shortcuts
	
	*todo*
	FIND UD AF ^ Uden at remmape en knap til når det skal offenliggøres.
	Find ud af de forskellige subsets, måske menu?
	!w=wolfaflpha markeret tekst?
	fiks vindue fokus paste rigtig sted 
	implementer \underset{1}{1} og \overset{}{}
	Lav general funktion til at vise forskellige symboler 
	Gør så at man kan have flere af samme pastemenu åben
	Lav icon til MadsBot LaTeX
	
	Links til diverse unicode symboler
	https://www.compart.com/en/unicode/block/U+2200		;matematisk univode block
	http://xahlee.info/comp/unicode_arrows.html
	https://en.wikipedia.org/wiki/Mathematical_operators_and_symbols_in_Unicode
	https://milde.users.sourceforge.net/LUCR/Math/unimathsymbols.pdf	(pdf med latex symboler)
	https://www.classe.cornell.edu/~dms79/LectureNotes/formulae/list-of-math-symbols-extended.htm'
	http://xahlee.info/comp/unicode_math_operators.html
	https://symbl.cc/en/collections/mathematical-signs/
*/

;højre shift højre kontrol til at togle makroerne til go fra
>^>+esc::msgbox, % "Madsbot LaTeX blocker is now set to " . Madsbot_LaTeX_blocker:=!Madsbot_LaTeX_blocker	;udtrykket er negeret af ahk jank grunde
#if !Madsbot_LaTeX_blocker	;hvis ikke blockeren er slået til,

^å::\	;control å til \

;right control sektionen. >+ betyder højre shift, <+ betyder venstre shift
;Højre shift er default, venstre shift er en modification.
>^>+r::ℝ	;real tal symbolet
>^>+q::ℚ	;rationelle tal symbolet
>^>+z::ℤ	;hele tal symbolet
>^>+n::ℕ	;naturlige tal symbolet
>^>+c::ℂ	;komplekse tal symbolet
>^>+-::∖	;differens mængde
>^>+p::∈	;part
;>^<+p::∉	;notpart
>^<+p::SelectionMenu(["∈","∉","∋","∌","∊","∍"], "Part menu")
>^>+v::∀	;alkvantoren
>^<+v::⊥	;vinkelret
>^>+e::∃	;eksistenskvantoren
>^<+e::SelectionMenu(["∃","∀","∄"], "Kvator menu")
;>^<+e::∄	;eksistenskvantoren med streg ingennem
>^>+x::×	;kryds
>^>+s::⊆	;delmængde (subset)
>^<+s::SelectionMenu(["⊂","⊃","⊆","⊇","⊄","⊅","⊈","⊉", "⊊", "⊋", "⋐","⋑"], "Delmængde menu")	;delmængde menu
>^>+i::∫	;integral symbol
>^<+i::SelectionMenu(["∫","∬","∭","⨌","∮","∯","∰","⨍","⨎","⨏","⨐","∱","⨑","∲","∳","⨒","⨓","⨔","⨕","⨖","⨗","⨘","⨙","⨚","⨛","⨜","⨋","⌠","⌡"], "Integral menu")
>^>+f::¬	;not 
>^>+k::∘	;sammensat funrktion 	(k for kombineret)
;>^>+m::⟼	;funktions mappe pil
>^>+u::⊢	;underordnet symbol
>^>+d::∂	;blødt d
>^>+l::ℓ	;matematik l
>^>+8::∞	;uendelig
>^>+g::∇	;nabla 				(g for gradient)
>^>+t::✓	;tjekmark
>^>+h::̂ 	;hat over bogstav
>^>+b::̅ 	;bar over bogstav
;>^>+ø::∅	;tomme mængde
>^<+0::SelectionMenu(["=","≠","∼","∽","≈","≂","≃","⋍","≄","≅","≌","≆","≇","≉","≊","≋","≍","≎","≏","≐","≑","≒","≓","≔","≕","≖","≗","≙","≚","≜","≟","≡","≢","≭","⋕"], "Ligmed menu")

>^<+1::SelectionMenu(["|","∣","⟊","∤","⫮","∥","∦","⫲","⫳","⋕","⫽","⦀","⫵","⫻"], "lodrette streger")
>^<+2::SelectionMenu(["^","⁰","¹","²","³","⁴","⁵","⁶","⁷","⁸","⁹","⁺","⁻","⁼","⁽","⁾","√","∛","∜"],"Potenser menu")
>^<+m::SelectionMenu(["⟹","⟸","⟺","⟾","⟽","⇒","⇐","⇑","⇓","⇔","⇕","⇏","⇍","⇎","⤂","⤃","⤄","⤇","⤆","⇗","⇘","⇙","⇖","⇛","⇚","⤊","⤋","⭆","⭅","⟰","⟱"], "Medføre pile")
>^<+8::SelectionMenu(["(","[","{","⌈","⌊","⟨"], "Start parenteser")
>^<+9::SelectionMenu([")","]","}","⌉","⌋","⟩"], "Slut parenteser")
>^<++::SelectionMenu(["+","±","∓","⩱","⩲","∑","⨊","⨁","⊞","⨹","⧺","⧻"], "Plus menu")
>^<+.::SelectionMenu(["⋅","⋮","⋯","⋰","⋱","∴","∵","∶","∷","⦁","●"], "Prikker")
>^<+o::SelectionMenu(["○","◌","⊕","⊖","⊗","⊘","⊙","⊚","⊛","⊝","◍","◎","⌀","ø","∅","◦","°","○"],"Cirkel symboler")
;>^<+<::SelectionMenu(["<",">","≤","≥","≦","≧","≨","≩","≪","≫","≮","≯","≰","≱","≲","≳","≴","≵","≶","≷","≸","≹","≺","≻","≼","≽","≾","≿","⊀","⊁","⊰","⋖","⋗","⋘","⋙","⋚","⋛","⋞","⋟","⋠","⋡","⋦","⋧","⋨","⋩"], "Uligheder")
>^<+<::SelectionMenu(["≤","≥","≦","≧","≨","≩","≪","≫","≮","≯","≰","≱","≲","≳","≴","≵","≶","≷","≸","≹","≺","≻","≼","≽","≾","≿","⊀","⊁","⊰","⋖","⋗","⋘","⋙","⋚","⋛","⋞","⋟","⋠","⋡","⋦","⋧","⋨","⋩"], "Uligheder")

;----- Pile taster -----
;altgr+pile taster = impliaktions pile. Højre og venstre shift giver modifikationer
<^>!right::⟹ 		;lang højre implikation
<^>!left::⟸ 		;lang venstre implikation
<^>!up::⟺ 		;lang biimplikation
<^>!down::⇔ 		;kort biimplikation
<^>!>+right::⇒		;kort højre implikaiton
<^>!>+left::⇐		;kort venstre implikaiton
<^>!>+up::⇑		;kort opad implikaiton
<^>!>+down::⇓		;kort nedad implikaiton
<^>!<+right::⇏		;kort højre ikke implikaiton
<^>!<+left::⇍		;kort venstre ikke implikaiton
<^>!<+up::⇎		;kort ikke biimplikaiton
<^>!<+down::⇕		;kort opad biimplikaiton
;rightcontrol med højre/venstreshift piletaster
>^>+right::→		;højre pil
>^>+left::←		;venstrepil
>^>+up::↑			;op pil
>^>+down::↓		;ned pil
>^<+right::↦		;højre mapping pil (lodret steg i bunden)
>^<+left::↤		;venstre mapping pil (lodret steg i bunden)
>^<+up::∧			;og
>^<+down::∨		;eller
;begge shiftknapper og pile
<+>+right::⊂		;stærk delmængde mod højre
<+>+left::⊃		;stærk delmængde mod venstre
<+>+up::∩			;fællesmængde
<+>+down::∪		;foreningsmængde

;græske obstaver med altgr. Shift til store græske bogstaver. 
<^>!a::α ;Alpha
<^>!b::β ;Beta
<^>!g::γ ;Gamma
<^>!d::δ ;Delta
<^>!e::ε ;Epsilon
<^>!z::ζ ;Zeta
<^>!h::η ;Eta
<^>!t::θ ;Theta
<^>!j::ι ;Jota
<^>!i::ι ;Iota
<^>!k::κ ;Kappa
<^>!l::λ ;Lambda
<^>!m::μ ;My
<^>!n::ν ;Ny
<^>!x::ξ ;Xi
<^>!o::ο ;Omikron
<^>!p::π ;Pi
<^>!r::ρ ;Rho
<^>!s::σ ;Sigma
<^>!u::τ ;Tau
<^>!y::υ ;Ypsilon
<^>!f::φ ;Phi
<^>!c::χ ;Chi
<^>!w::ω ;Omega
<^>!v::ψ ;Psi
+<^>!a::Α ;Alpha
+<^>!b::Β ;Beta
+<^>!g::Γ ;Gamma
+<^>!d::Δ ;Delta
+<^>!e::Ε ;Epsilon
+<^>!z::Ζ ;Zeta
+<^>!h::Η ;Eta
+<^>!t::Θ ;Theta
+<^>!j::Ι ;Jota
+<^>!i::Ι ;Iota
+<^>!k::Κ ;Kappa
+<^>!l::Λ ;Lambda
+<^>!m::Μ ;My
+<^>!n::Ν ;Ny
+<^>!x::Ξ ;Xi
+<^>!o::Ο ;Omikron
+<^>!p::Π ;Pi
+<^>!r::Ρ ;Rho
+<^>!s::∑ ;Sigma
+<^>!u::Τ ;Tau
+<^>!y::υ ;Ypsilon
+<^>!f::Φ ;Phi
+<^>!c::Χ ;Chi
+<^>!w::Ω ;Omega
+<^>!v::Ψ ;Psi 

;Diverse matematiske hotstrings. 
:*?:<=::≤
:*?:=<::≤
:*?:>=::≥
:*?:=>::≥
:*?:/<::≮		;ikke mindre end
:*?:/>::≯		;ikke større end
:*?:</=::≰	;ikke mindre eller lig end
:*?:>/=::≱ 	;ikke større eller lig end
:*?:=ish::≈
:*?:/=::≠ 	;er efter ulighederne der også bruger /=, for at de også virker
:*?:~=::≃			;isomorf, altså tilde ligmed. 
:*?:sinx::sin(x)
:*?:siny::sin(y)
:*?:sint::sin(t)
:*?X:sin2::paste("sin^2")
:*?:sinhx::sinh(x)
:*?:sinhy::sinh(y)
:*?:sinht::sinh(t)
:*?:cosx::cos(x)
:*?:cosy::cos(y)
:*?:cost::cos(t)
:*?X:cos2::paste("cos^2")
:*?:coshx::cosh(x)
:*?:coshy::cosh(y)
:*?:cosht::cosh(t)
:*?:tanx::tan(x)
:*?:tany::tan(y)
:*?:tan2::tan^2
:*?:tanhx::tanh(x)
:*?:tanhy::tanh(y)
:*?:logx::log(x)
:*?:logn::log(n)
:*?:fx::f(x)
:*?:gx::g(x)
;<^>!ø::send, ⋅		;fancy gangetegn (altså en prik)
;<^>!æ::send, ⋅		;fancy gangetegn (altså en prik)
^ø::send, ⋅		;fancy gangetegn (altså en prik)
^æ::send, ⋅		;fancy gangetegn (altså en prik)
:*?:...1::⋯		;middle line 3 dots
:*?:...2::⋱		;diagonal 3 dots
:*?:...3::⋮		;vertical 3 dots
:*?:→/::↛			;højre pil med skæv streg igennem
:*?x:\gulv::paste("⌊⌋", "{left}")
:*?x:\loft::paste("⌈⌉", "{left}")
:*?x:\vinkelret::paste("⊥")
:*?x:\symbols::msgbox, ⊢⊣⊤⊥ ⊂⊃⊆⊇⊄⊅⊈⊉⋐⋑		;tacks, subsets,
;Andre hotstrings
:*?X:\unicode::run, www.compart.com/en/unicode/block/U+2200
:*?X:\latexunicode::run, https://milde.users.sourceforge.net/LUCR/Math/unimathsymbols.pdf
:*?X:\help::run, "https://github.com/MadsPhilipsen/MadsBot-LaTeX/blob/main/MadsBot-LaTeX.ahk"
:*?X:\hjælp::run, "https://github.com/MadsPhilipsen/MadsBot-LaTeX/blob/main/MadsBot-LaTeX.ahk"
:*?X:\kode::run, notepad.exe %A_ScriptDir%/%A_ScriptName%
:*?:\inddeling::$D:\ a=x_0<x_1<...<x_n=b$
;Paste fra filer hotstrings, til at paste meget
:*?X:\skabalon::PasteFromTxtFile("Data\LaTeX_skabalon.txt")
:*?X:\forside::PasteFromTxtFile("Data\LaTeX_forside.txt")
:*?X:\footer::PasteFromTxtFile("Data\LaTeX_footer.txt")

;Alt laget. Alt knappen er bundet til mere komplekse makroer. 
;"Simple" alt makroer, der kun kræver en linje kode
<!w::run, www.wolframalpha.com
<!s::MenuPaste("Sum fra [1] til [2] over [3]", "∑_{【1】}^{【2】}{【3】}", "sum")		;alt s = sum
<^<!s::paste("∑_{i=1}^{n}{}", "{left 1}")	;venstre kontrol alt s = sum med i=1 til n
<+<!s::paste("∑_{n=0}^{∞}{}", "{left 1}")	;venstre plus alt s = sum med n=1 til ∞
<!d::MenuPaste("Brøk: [1] divideret med [2]", "\frac{【1】}{【2】}", "brøkker")	;alt d = brøk menu
<!<^d::paste("\frac{}{}", "{left 3}")		;kontrol alt d = brøk
<!<+d::pasteAroundSelected("\frac{", "}{}", "{left}")
<!i::MenuPaste("Integral fra [1] til [2] af [3]", "∫_{【1】}^{【2】}{【3】}", "integral")
<^<!i::paste("∫_{a}^{b}{}", "{left 1}")		;kontrol alt i = integral fra a til b
;<!u::MenuPaste("Løsning af integral: [[3]]_[1]^[2]", "[【3】]_{【1】}^{【2】}", "integralløsning")
<!l::MenuPaste("Grænseværdi for [1] gående mod [2] af [3]", "\lim_{【1】→【2】}{【3】}", "grænseværdi")
<^<!l::paste("\lim_{n→∞}{}", "{left}")		;kontrol alt l = limit
<!p::MenuPaste("Partielt afledt: Funktion=[1], variabel=[2]", "\frac{∂【1】}{∂【2】}", "partieltAfledt")
;<!u::paste("⋃_{}^{}{}","{left 6}")			;alt u = fællesmængde med interval
<!k::menupaste("konjuger [1]", "\overline{【1】}", "konjugeret")		;alt k = konjugeret
<!h::menupaste("hat over [1]", "\widehat{【1】}", "hat")
<!<+h::pasteAroundSelected("\widehat{","}")
;<!o::menupaste("[2] over [1]", "\stackrel{\text{【2】}}{【1】}", "over")	;tekst over tekst
<!o::menupaste("[2] over [1]", "\overset{【2】}{【1】}", "over")
<!<+o::menupaste("over markeret", "\stackrel{\text{【1】}}{" . getSelected() . "}")
<!u::menupaste("[2] under [1]", "\underset{【2】}{【1】}", "under")
<!r::menupaste("[1] som tekst", "\text{【1】}", "text")	;tekst over tekst
<!<+r::pasteAroundSelected("\text{", "}")
<!<^r::paste("\text{}", "{left 1}")	
<!f::menupaste("Følgens navn: [1] i indekset [2] som ligger i [3]", "\{【1】_{【2】}\}_{【2】∈【3】}", "følger")	;alt f = m
<!v::menupaste("Vector pil over [1]", "\vec{【1】}", "vectorpil")
<!<+v::pasteAroundSelected("\vec{","}")
<!t::paste("\{\}", "{left 2}")			;alt t = tuborgparentesi\intt_t_{}^{}{}}}}}
>+-::paste("_{}","{left}")				;højreshift minus = subscrit med tuborg klap
;+<!-pasteAroundSelected("_{","}")
<!a::paste("^*")						;Adjungeret
;<!<::paste("⟨⟩", "{left 1}")				;indre produkt
<!<::paste("⌊⌋", "{left}")				;gulv
<!<+<::paste("⌈⌉", "{left}")				;lfot
<!c::paste("\begin{cases}\end{cases}", "{left 11}{enter 2}{left}")
<!<+c::pasteAroundSelected("\begin{cases}","\end{cases}")
<!1::paste("^{-1}") 					;alt 1 = invers
<!<+1::pasteAroundSelected("\frac{1}{","}")
<!2::paste("\sqrt{}", "{left}")			;alt 2 = √
<!3::menupaste("[1]'te rod af [2]","\sqrt[【1】]{【2】}", "nroot")			;alt 3 = n rod, hvor jeg kan ændre n. 
<!0::paste("\{0\}")						;alt 0 = singleton 0
;matematik felter
<!æ::paste("$")							;alt æ til ligning i linje (virker i overleaf)
<!ø::paste("$$", "{left}")					;alt ø til ligning i linje (virker i obsidian)
<!'::paste("\begin{align}\end{align}", "{left 11}{enter 2}{left}")	;alt ' til align ligning
<!<+'::pasteAroundSelected("\begin{align}","\end{align}")
<^>!ø::send, {end}{enter}$$$${left 2}	;til programmer der ikke automatisk sætter to $
<^>!æ::send, {end}{enter}$$			;til programmer der automatisk sætter to $
+^æ::pasteAroundSelected("$", "$")		;sætter $ omkring markeret
+^ø::pasteAroundSelected("$$", "$$")	;sætter $$ omkring markeret
<!space::menupaste("Hurtig ligning: $[1]$", "$【1】$", "ligninger")
;mellemrum i matematik felter
<^>!space::paste("\ ")					;lave rigtige mellemrum i matematik felt
>^space::paste("\quad ")					;laver næst størst mellemrum i mateamtik felt
<^>!>^space::paste("\qquad ")				;laver størst mellemrum i matematik felt
<^>!,::paste(",\ ")						;Laver comma i matematik felt med efterfulgt af mellemrum
>^,::paste(",\quad ")					;laver comma+næst størst mellemrum i mateamtik felt
<^>!>^,::paste(",\qquad ")				;laver comma+størst mellemrum i matematik felt
<^space::send, {end}{space}				;mellemrum til sidst i linjen
;enters i LaTeX
<^>!enter::paste("\\","{enter}")			;Ordenligt nylinje i latex
<^>!>^enter::send, {end}\\{enter}			;Forlad linje med \\
;andet
<^>!.::send, {end}.\\{enter}	;punktum til sids<t på linje, ny linje


;venstre alt venstre kontrol + tal til headings
<!<^1::paste("\section*{}","{left}")	
<!<^2::paste("\subsection*{}", "{left}")
<!<^3::paste("\subsubsection*{}","{left}")
<!<^4::paste("\paragraph{}","{left}")
;andre heading shortcuts
:*?X:\date::paste("\section*{" . date() . "}")			;skriver automatisk dagens dato
:*?X:\def::paste("\subsubsection*{Definition }", "{left}") 
:*?X:\sæt::paste("\subsubsection*{Sætning }", "{left}")
:*?X:\kor::paste("\subsubsection*{Korollar }", "{left}")
:*?X:\lem::paste("\subsubsection*{Lemma }", "{left}")
:*?X:\rem::paste("\subsubsection*{Remark }", "{left}")
:*?X:\bem::paste("\subsubsection*{Bemærk}")
:*?X:\prop::paste("\subsubsection*{Proposition}")
:*?X:\husk::paste("\subsubsection*{Husk }")
:*?X:\eks::paste("\subsubsection*{Eksempel }", "{left}")
:*?X:\ex::paste("\subsubsection*{Example }", "{left}")
:*?X:\spø::paste("\subsubsection*{Spørgsmål}", "{left}")
:*?X:\opg::paste("\subsection*{Opgaver}")
:*?X:\stdop::paste("\subsubsection*{Standard opgave }", "{left}")

;mere komplicerede alt makroer
<!-::	;alt - for bogstav efterfulgt af underscore  text
;text := input("Tekst over ting før mellemrum")
input, text, L2
list := StrSplit(text,,,2)	;splits string in two parts
paste("$" . list[1] . "_{" . list[2] . "}$ ")
return

<!.::	;alt . auto lister
InputBox, characters
if ErrorLevel
	return
list :=  StrSplit(characters, A_space)
var := list[1]
text := ""
for char, v in list {
	if (char = 1)
		continue
	if (v = ".") {
		text .= "...,"
		continue
	}
	if instr(v, ".") {
		list2 := strsplit(v, ".")
		text .= var . "_{" . list2[1] . "},...," . var . "_{" . list2[2] . "}"
		continue
	}
	if (char = list.length()) {
		text .= var . "_{" . v . "}"
		break
	}	
	text .= var .  "_{" . v . "},"
}
paste(text)
return

<!m::	;Matrix makroen! Det er ikke en funktion af *banker hovedet i bordet* "årsager"
if WinExist("Madsbot: Madstrix") {			;Hvis allerede åben
	if !winactive("Madsbot: Madstrix")		;Hvis ikke aktive vindue
		WinActivate, Madsbot: Madstrix	;fokuser på vindue
	return							;Lav værd med at lave ny (kan chrashe)
}
matrixformats := [new MatrixFormat("( )", "\begin{pmatrix}`n", "&", "\\`n", "`n\end{pmatrix}")
, new MatrixFormat("[ ]", "\begin{bmatrix}`n", "&", "\\`n", "`n\end{bmatrix}")
, new MatrixFormat("{ }", "\begin{Bmatrix}`n", "&", "\\`n", "`n\end{Bmatrix}")
, new MatrixFormat("ǀ ǀ", "\begin{vmatrix}`n", "&", "\\`n", "`n\end{vmatrix}")
, new MatrixFormat("‖ ‖", "\begin{Vmatrix}`n", "&", "\\`n", "`n\end{Vmatrix}")
, new MatrixFormat("Ø", "\begin{matrix}`n", "&", "\\`n", "n\end{Vmatrix}")
, new MatrixFormat("ary", "\left(\begin{array}{}`n", "&", "\\`n", "\end{array}\right)")
, new MatrixFormat("wα", "{{" , "," , "},{", "}}")
, new MatrixFormat(chr(127809), "<<", "|", ">,<", ">>")]	;chr(127809) er symbolet for et maple leaf. Det rå unicode symbol chrashede min IDE
matrixformats_n := matrixformats.length()
matrixinputrows := matrixformats.length()-1.25
pasteModes := ""
for i, m in matrixformats {
	pasteModes .= m.name . "|"
}	StringTrimRight, pasteModes, pasteModes, 1	;fjerner sidste | i pastemodes
matricer := ""
Loop, %matrixformats_n% {
	iniread, download, Data\savedata.ini, matrix, %A_Index%
	matrix := StrReplace(download, "Æ", " ")
	matricer .= matrix . "|"				;skift den her ud med et andet bogstav når den gemmes?‽‽‽‽‽!
	NumberOfMatrices := A_Index
}  	StringTrimRight, matricer, matricer, 1	;fjerner sidste |
iniread, defaultFormat, Data\savedata.ini, matrix, LastFormat
if (defaultFormat<1 or defaultFormat>matrixformats.length())	;hvis der gik noget galt i at loade default format
	defaultFormat := 1									;sæt det til 1.

gui_height := matrixformats_n*30+8
gui, MatrixMaker:new, +HwndGuiHwnd +ToolWindow, Madsbot: Madstrix	;always on top
gui, MatrixMaker:Default
gui, font, s20
gui, show, xcenter ycenter w600 h%gui_height%
gui, add, Edit, x0 y0 w300 r%matrixinputrows% vMatrixInput
gui, add, button, x0 y+0 wp-108 h36 vMatrixButton gCreateMatrix, Insert Matrix
gui, add, button, x+0 yp w68 h36 vMatrixHelpButton gMatrixHelp, Help
gui, add, comboBox, x+0 yp w40 h32 vMatrixSaveSlot Choose1, 1|2|3|4|5|6|7|8|9
gui, add, listbox, x300 y0 w260 r%matrixformats_n% vMatrixSelector gMatrixChangeInput, %matricer%
gui, add, listbox, x560 y0 w40 r%matrixformats_n% vMatrixPasteMode Choose%defaultFormat%, %pasteModes%
funcObject1 := func("MatrixLoadNext").bind(GuiHwnd)
funcObject2 := func("MatrixLoadPrevios").bind(GuiHwnd)
funcObject3 := func("MatrixNextFormat").bind(GuiHwnd)	;referance til select nedad i ListBox
funcObject4 := func("MatrixPreviousFormat").bind(GuiHwnd)		;referance til select opad i listbox
hotkey, IfWinActive, Madsbot: Madstrix			;gør knapper kun virker hvis vindue aktivt
hotkey, ^enter, CreateMatrix, on
hotkey, escape, ExitMatrixMaker, on
hotkey, ^down, % funcObject1, on
hotkey ^up, % funcObject2, On
hotkey, ^right, % funcObject3, On
hotkey, ^left, % funcObject4, On
loop, % min(9, matrixformats_n) {	;looper igennem hver gemt matrix. Højst til 9, da der er ni talknapper på tastaturet
	funcObject := func("MatrixSetSaveSlot").bind(A_index, GuiHwnd)
	hotkey, ^%A_index%, % funcObject, on
}
guicontrol, Focus, MatrixInput
return

paste(text, send := "") {	; has a second optional argument for any text to send. 
	sleep, 100
	sendinput, {text}%text%
	if send
		send, % send
} ClipBoardPaste(text, send := "") {	;paster med clipboardet istedet. Har fordele i visse speficike situationer, men er langsomere
	clipSaved := clipboardAll
	clipboard := text
	send, ^v
	sleep, 150	;delay sådan at det paster det rigtige. 
	clipwait		;idk, hjælper måske?
	clipboard := clipSaved
	clipSaved := ""
	if send
		send, % send
} PasteFromTxtFile(path) {
	if !FileExist(path) {
		msgbox, % "Latex Skabalon findes ikke. Lav venligst en " . path . " i mappen hvor dette skript ligger"
		return
	} else {
		fileread, text, % path
		sleep, 100
		ClipboardPaste(text)
	}
} getSelected() {
	clipSaved := ClipboardAll		;for restating it later
	clipText := Clipboard			;for testing if it maches
	send, ^c						;update clipboard
	sleep, 50 					;sleep. Shits buggy
	var := clipboard
	clipboard := clipSaved			;restore clipboardet
	clipSaved := ""				;slet clipsaved
	return, var
} pasteAroundSelected(text1, text2, send := "") {
	clipSaved := ClipboardAll		;for restating it later
	clipText := Clipboard			;for testing if it maches
	send, ^c						;update clipboard
	sleep, 50 					;sleep. Shits buggy
	paste(text1 . clipboard . text2)	;paste the new thing
	;sleep, 50					;stadig buggy uden????
	clipboard := clipSaved			;restore clipboardet
	clipSaved := ""				;slet clipsaved
	if send
		send, % send
	return
} date() {
	formatTime, CurrentDate,, dd/MM/yyyy
	return, CurrentDate
} input(titel:="Input") {	;creates inputbox and returns input
	InputBox, Input, %title%
	return, Input
} 

MenuPaste(titel, text, savesektion:="") {
	global GemtSelector
	if WinExist(titel) {			;Hvis allerede åben
		if !winactive(titel)		;Hvis ikke aktive vindue
			WinActivate, % titel 	;fokuser på vindue
		return					;Lav værd med at lave ny (kan chrashe)
	}
	gui, new, +HwndGuiHwnd +AlwaysOnTop +ToolWindow, %titel%	;laver gui	+Hwnd laver guis HWND til handle
	gui, %GuiHwnd%:Default				;sætter til default for thread
	gui, show, xcenter ycenter w256 h256	;Viser vindue
	gui, font, s16						;Sætter font
	gui, add, Edit, x0 y0 w256 r2 vInput, 	;laver edit boks med en row
	gui, font, s12
	guicontrol, Focus, Input				;Fokusere på inputboksen
	iniread, saveslot, Data\savedata.ini, %savesektion%, currentSaveSlot	;loader saveslot
	
	slots := 10
	if (saveslot="ERROR")
		saveslot := -1 
	saveslot := mod(saveslot+1, slots)	;bruger næste saveslot
	gemt := ""
	Loop, %slots% {				;laver listen med gamle inputs
		iniread, download, Data\savedata.ini, %savesektion%, % mod(slots+saveslot-(A_Index), slots)
		gemt .= download . "|"
	}
	StringTrimRight, gemt, gemt, 1	;fjerner sidste | som splitter dem op
	gui, add, Listbox, x0 y54 w256 r%slots% vGemtSelector ReadOnly, %gemt%	;laver listboksen med gamle inputs
	UpdateField := func("MenuPasteUpdateField").bind(GuiHwnd)		;laver funktionsrefereance til opdater field
	Guicontrol, +g, GemtSelector, % UpdateField					;binder funktions referance til listboksen
	
	funcObject1 := func("MenuPasteSplitSend").bind(GuiHwnd, text, savesektion, saveslot, mod(saveslot-1, slots))	;referance til send funktion
	funcObject2 := func("MenuPasteExit").bind(GuiHwnd)		;referance til luk funktion
	funcObject3 := func("MenuPasteSelectDown").bind(GuiHwnd)	;referance til select nedad i ListBox
	funcObject4 := func("MenuPasteSelectUp").bind(GuiHwnd)		;referance til select opad i listbox
	
	hotkey, IfWinActive, %titel%			;gør knapper kun virker hvis vindue aktivt
	hotkey, enter, % funcObject1, on		;enter til at sende ting og lukke vindue
	hotkey, escape, % funcObject2, on		;escape til at lukke vindue.
	hotkey, down, % funcObject3, on		;pil ned til select nedad i listbox
	hotkey, up, % funcObject4, on			;pil op til select opad i listbox
} MenuPasteSplitSend(gui, text, savesektion:="",  saveslot:="", previousslot:="") {
	originalText := text
	global Input			;Gør den kan hente inputtet i tekstboksen
	gui, %gui%:submit		;gemmer indenhold i input variablen
	RegExReplace(text, "【",, count)		;tæller hvor mange led der er i teksten, så ekstra tring kan gå i sidste led
	list := StrSplit(Input, " ",,count)	;splits string i det antal led der skal være, hvor sidste lad kan indenholde mellemrum. 
	hotkey, enter, off		;disables hotkey 
	hotkey, escape, off		
	hotkey, down, off
	hotkey, up, off
	gui, cancel			;close gui
	for n, val in List 		;opdatere text indenholdet til at indenholde inputtet
		text := StrReplace(text, "【" n "】", val)	;bruger skøre brackets for at undgå konflikter med brugs situationer
	text := RegExReplace(text, "【(.*?)*】",, -1)		;fjerner ekstra 【n】 som ikke blev udfyldt, hvis de findes
	paste(text)
	if savesektion {				;hvis savesektion er angviet, så skal det gemmes
		sanitiezedInput := StrReplace(Input, "|", "｜") 						;| ødelægger *ting* så udskiftes med en lidt anden vertical linje
		iniread, previous, Data\savedata.ini, %savesektion%, %previousslot%			;hvad var sidste gemt
		if (sanitiezedInput != previous) {												;hvis input ikke allerede er gemt, så gem
			iniwrite, %saveslot%, Data\savedata.ini, %savesektion%, currentSaveSlot	;gemmer saveslot til næste gang
			iniwrite, %sanitiezedInput%, Data\savedata.ini, %savesektion%, %saveslot%			;gemmer inputtet i saveslot
		}
	}
} MenuPasteExit(gui) {
	hotkey, enter, off		;disables hotkey
	hotkey, escape, off		
	hotkey, down, off
	hotkey, up, off
	gui, %gui%:cancel		;close gui
	Exit					;lukker thread
} MenuPasteUpdateField(gui) {
	global GemtSelector			;Gør den kan hente inputtet i tekstboksen
	gui, %gui%:submit, nohide	;gemmer indenhold i input variablen
	unsanitiezedInput := StrReplace(GemtSelector, "｜", "|")	;Inputter var gemt med "|" ændret til "｜" da |  bruges til ting i ahk. Det ændres tilbage
	guicontrol, %gui%:text, Input, %unsanitiezedInput%
} MenuPasteSelectDown(gui) {
	ControlSend, ListBox1, {down}, ahk_id %gui%	;send pil ned til listbox kontrollen i gui
} MenuPasteSelectUp(gui) {
	ControlSend, ListBox1, {up}, ahk_id %gui%	;send pil op til listbox kontrollen i gui
}

SelectionMenu(list, titel) {
	gui, new, +HwndGuiHwnd +AlwaysOnTop +ToolWindow, %titel%	;laver gui	+Hwnd laver guis HWND til handle
	gui, %GuiHwnd%:Default				;sætter til default for thread
	gui, margin, 0, 0
	hotkey, IfWinActive, %titel%			;gør knapper kun virker hvis vindue aktivt
	escapeObject := func("CloseSelectionMenu").bind(GuiHwnd, keymap)
	hotkey, escape, % escapeObject, on		;escape til at lukke vindue.
	keymap := {1: "1", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8", 9: "9", 10: "0", 11: "+", 12: "q", 13: "w", 14: "e", 15: "r", 16: "t", 17: "y", 18: "u"
	, 19: "i", 20: "o", 21: "p", 22: "å", 23: "a", 24: "s", 25: "d", 26: "f", 27: "g", 28: "h", 29: "j", 30: "k", 31: "l", 32: "æ", 33: "ø", 34: "<", 35: "z", 36: "x"
	, 37: "c", 38: "v", 39: "b", 40: "n", 41: "m", 42: ",", 43: "."}
	for i, text in list {
		gui, font, s16
		gui, add, button, x+0 y0 h32, %text%
		gui, font, s12
		gui, add, text, xp y32 wp h32 center, % keymap[i]
		funcObject := func("SelectionMenuPaste").bind(GuiHwnd, text, keymap)
		guicontrol +g, %text%, % funcObject
		hotkey, % keymap[i], % funcObject, on
	}
	helpObjet := func("SelectionMenuHelp")
	gui, add, button, x+0 y0 w50 h32, help
	guicontrol +g, help, % helpObjet
	gui, show, xcenter ycenter h54	;Viser vindue
} SelectionMenuPaste(gui, text, keymap) {
	CloseSelectionMenu(gui, keymap)
	paste(text)
} CloseSelectionMenu(gui, keymap) {
	gui, %gui%:cancel		;close gui
	for i, key in keymap
		try, hotkey, %key%, off
	;loop listlength
		;try, hotkey %A_index%, off
} SelectionMenuHelp() {
	msgbox, Vælg teksten der skal sendes ved at klikke på knappen eller dens korsponderende tast på tastaturet som står neden under.
}

;gui, add, button, x0 y+0 wp-40 h36 vMatrixButton gCreateMatrix, Insert Matrix

Class MatrixFormat {
	__New(name, before, spaceSeperator, enterSeperator, after)
	{
		this.name := name
		this.before := before
		this.spaceSeperator := spaceSeperator
		this.enterSeperator := enterSeperator
		this.after := after
	}
}

formatMatrix(input, before, spaceSeperator, enterSeperator, after) {
	text := ""
	list1 := StrSplit(input, "`n")			;enter
	for i, str in list1 {					;for hver linje
		list2 := StrSplit(str, A_Space)		;space
		for j, v in list2 {					;for hver element i linje
			if (A_Index != list2.length())	;hvis ikke sidste element i linjen
				text .= v . spaceSeperator	;tilføj element og spaceseperatoren
			else							;hvis sidste elemnt i linjen
				text .= v					;tilføj kun elementet
		}
		if (A_Index != list1.length())		;hvis det ikke er den sidste linje
			text .= enterSeperator			;tilføj enterseperatoren
	}
	return, before . text . after
}

return				;matrix  subrutiner
CreateMatrix:
Gui, MatrixMaker:Default	
Gui, Submit, nohide		;store gui data to variables
gui, Destroy			;close gui
for i, m in matrixFormats {			;looper igennem matricer
	if (m.name == MatrixPasteMode) 	;matcher matrice pastemodeformatet
		format := m, format_n := i	;gem formatet og formattallet
}
if format							;hvis et format blev fundet, send matricen
	paste(formatMatrix(MatrixInput, format.before, format.spaceSeperator, format.enterSeperator, format.after))
else								;hvis et format ikke blev fundet, send en error message.
	msgbox, Noget gik galt. Kunne ikke finde en matrix∈matrixformats der matchede MatrixPasteMode. Hvis du ser denne besked så send mig lige en besked ik?
MatrixDisableHotkeys()
upload := StrReplace(MatrixInput, A_Space, "Æ")
upload := StrReplace(upload, "`n", "→")
if !FileExist("Data\savedata.ini")	{		; findes fill ikke
	msgbox, Der findes ikke en Data\savedata.ini i scriptets mappe. Lav den venligst så matricerne automatisk gemmes.
}
if instr(upload, "|") {
	msgbox, Der er | i din matrix, hvilket ødelægger alt. Det er besværligt at fikse, derfor gemmes den ikke :(
	
	return
}
;sanitiezedUpload := StrReplace(upload, "|", "｜") 		;| ødelægger *ting* så udskiftes med en lidt anden vertical linje
iniwrite, %upload%, Data\savedata.ini, matrix, % MatrixSaveSlot
iniwrite, %format_n%, Data\savedata.ini, matrix, LastFormat
return
MatrixChangeInput:
Gui, MatrixMaker:Default
Gui, Submit, nohide
matrix := StrReplace(MatrixSelector, "→", "`n")
guicontrol, text, MatrixInput, %matrix%
return
ExitMatrixMaker:
MatrixDisableHotkeys()
gui, MatrixMaker:cancel			;close gui
return
MatrixHelp:
msgbox,, MatrixHelp, 
(
Skriv matricen ved at sepererer med mellemrum og nyline (enter), som f.eks:
1 2
3 4
Kontrol+enter for at gemme matricen, lukke viduet og paste matricen.
Kontrol+pilop/pilned for at loade gamle matricer. 
Kontrol+venstre/højrepil for at vælge matrix formateringen.
Kontrol+tallet for linjen hvor matricen skal gemmes.
)
return
MatrixDisableHotkeys() {
	try, hotkey, ^enter, off		;disables hotkey
	try, hotkey, escape, off		;try for at undgå en errormessage en mærkelig gang
	try, hotkey, ^up, off
	try, hotkey, ^down, off
	loop, 9 {						;looper igennem alle 9 talknapper på tastaturet
		try, hotkey, ^%A_index%, off	;disables hotkey. Try for hvis der er mindre end 9 saveslots
	}
} MatrixSetSaveSlot(slot, gui) {
	Gui, %gui%:Submit, nohide
	Guicontrol, %gui%:Choose, MatrixSaveSlot, %slot%	;vælg slot
} MatrixLoadNext(gui) {
	ControlSend, ListBox1, {down}, ahk_id %gui%	;send pil ned til listbox kontrollen i gui
} MatrixLoadPrevios(gui) {
	ControlSend, ListBox1, {up}, ahk_id %gui%	;send pil ned til listbox kontrollen i gui
} MatrixNextFormat(gui) {
	ControlSend, ListBox2, {down}, ahk_id %gui%	;send pil ned til listbox kontrollen i gui
} MatrixPreviousFormat(gui) {
	ControlSend, ListBox2, {up}, ahk_id %gui%	;send pil op til listbox kontrollen i gui
}
#if