extends LineEdit
func _ready():
	connect("text_changed",self,"_on_LineEdit_text_changed")

export var regexLimitString = '[0-9]'
export var maxCharacters = 0

func _on_LineEdit_text_changed( text ):
	var cursorPos = get_cursor_pos()
	if regexLimitString.length() > 0:## limit what characters
		set_text(returnSpecificSymbolsOnly(text,regexLimitString))
	if text.length() > maxCharacters and maxCharacters != 0: # limit how many characters 
		set_text(get_text().substr(0,get_text().length()-1))
	set_cursor_pos(cursorPos)

func returnSpecificSymbolsOnly(enteredText,regex):
	var word = ''
	for letter in enteredText:
		var resultingText = RegEx.new()
		resultingText.compile(regex,9) #search pattern
		if resultingText.find(letter,0,-1) != -1 : word = word+letter
	return word