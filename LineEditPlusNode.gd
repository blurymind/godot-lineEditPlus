extends LineEdit

export(String, "Numeric", "Any", "Regex") var inputType = "Numeric"
export var regexLimitString = '[0-9]'

export var limitRange = true
export var minNum = 0
export var maxNum = 100

#export var maxCharacters = 0
var tooltiptext = ""
var startingTooltip = ''
func _ready():
	startingTooltip = get_tooltip()
	connect("text_changed",self,"_on_LineEdit_text_changed")
	connect("input_event",self,"_on_inputEvent")
	updateInputType()
	updateTooltip()


func updateInputType():
	if inputType == "Numeric":
		regexLimitString = '[0-9-]'
	elif inputType == "Any":
		regexLimitString = ''
	elif inputType == "Regex":
		pass

func _on_LineEdit_text_changed( text ):
	var cursorPos = get_cursor_pos()
	if regexLimitString.length() > 0:## limit what characters
		set_text(returnSpecificSymbolsOnly(text,regexLimitString))
	
	if inputType == "Numeric":##if numeric - use min and max
		if limitRange == true:
			limitNumericInput()
	set_cursor_pos(cursorPos)
	updateTooltip()

func updateTooltip():
	if inputType == "Numeric":
		tooltiptext = "Hint: " + startingTooltip + "\nAccepting only numeric values\n"
		if limitRange == true: tooltiptext = tooltiptext+ "Min: " + str(minNum) + "  Max: " + str(maxNum)
		if inputActionIncreaseNum.length() !=0 and inputActionDecreaseNum.length() !=0:
			tooltiptext = tooltiptext + "\nPress " + inputActionIncreaseNum + " to increase the value by "+str(inputNumStep)+".\nPress "+inputActionDecreaseNum+" to decrease the value by "+str(inputNumStep)+"."
			if cycleNumInput==true:tooltiptext = tooltiptext + "\nInput can Cycle the value."
	set_tooltip(tooltiptext)

func returnSpecificSymbolsOnly(enteredText,regex):
	var word = ''
	for letter in enteredText:
		var resultingText = RegEx.new()
		resultingText.compile(regex,9) #search pattern
		if resultingText.find(letter,0,-1) != -1 : word = word+letter
	return word

export var inputActionIncreaseNum = 'ui_right'
export var inputActionDecreaseNum = 'ui_left'
export var inputNumStep = 1
export var cycleNumInput =true
func _on_inputEvent(event):
	if inputType == "Numeric":
		if Input.is_action_pressed(inputActionIncreaseNum) and get_cursor_pos()==get_text().length():
			set_text(str(int(get_text())+inputNumStep))
			set_cursor_pos(get_text().length())
#			print("increase")
		elif Input.is_action_pressed(inputActionDecreaseNum) and get_cursor_pos()==0:
			set_text(str(int(get_text())-inputNumStep))
			set_cursor_pos(0)
#			print("decrease")
		if limitRange == true:limitNumericInput()

func limitNumericInput():
	if get_text().length() != 0:
#		var validateNumRange = clamp(int(get_text()),minNum,maxNum)
		if cycleNumInput == true:
			if int(get_text()) > maxNum:
				set_text(str(0))
			if int(get_text()) < minNum:
				set_text(str(maxNum))
		else:
			if int(get_text()) > maxNum and get_text().length() !=0:
				set_text(str(maxNum))
			if int(get_text()) < minNum and get_text().length() !=0:
				set_text(str(minNum))
