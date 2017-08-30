# godot-lineEditPlus
A line edit node with the ability to limit what characters can be entered via a Regular expression string and also limit how many characters can be entered.

Variables:
- inputType -select between numeric, any or regex input. Determines what kind of input can be entered. Selecting numeric will force the input to be only numeric and will also  use the additional options provided for numeric input. Regex allows you to use a custom regexLimitString. For example '[0-9]' would limit it to numeric only. 
- limitRange - Enabling this will force a numeric limit range for numeric input.
- min/maxNum - Establish the minimum and maximum number for that range
- inputActionIncreaseNum - You can assign an input action that will trigger increasing the numeric value in the input box
- inputActionDecreaseNum - You can assign an input action that will trigger decreasing the numeric value in the input box
- inputNumStep - This variable determines by what amount the numeric value is increased or decreased by the input actions
- cycleNumInput - If this is enabled, once the numeric input is higher than its maxNum value , it will jump to the minNum value and continue from there. The same applies also if it hits bellow the minNum , it will then jump to the maxNum - in essence making the numeric value cycle

on Regex: 
- for example using [0-9] for the regexLimitString would allow only numbers to be entered
- using [A-Za-z ] for the regexLimitString would allow only letters to be entered

You can also limit how many characters can be entered via the maxCharacters int
