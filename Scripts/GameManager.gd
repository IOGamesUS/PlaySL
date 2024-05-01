extends Node

var Signs = {
	1:"1", 2:"2", 3:"3", 4:"4", 5:"5", 6:"6", 7:"7", 8:"8", 9:"9", 10:"10"
}

var Operations = {
	1:"Plus", 2:"Minus"
}
	
var ActiveSign
var Score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	_on_NewRound()
	
func _input(event):
	if Input.is_key_pressed(KEY_ENTER) and event.is_pressed() and not event.is_echo():
		_on_Button_pressed()

func _on_NewRound():
	var prompt = find_child("Prompt")
	prompt.text = ""
	prompt.grab_focus()
	randomize();
	var signs = Signs.values()
	ActiveSign = signs[randi() % signs.size()]
	_switch_image(ActiveSign)

func _switch_image(signChar):
	var signContainer = find_child("Sign");
	signContainer.texture = load("res://Images/Signs/" + signChar + ".jpg")
	
func _set_instruction_text(newInstruction):
	var instructionContainer = find_child("Instruction")
	instructionContainer.text = newInstruction
	
func _set_score_text(score):
	var scoreContainer = find_child("Score")
	scoreContainer.text = "Score: " + String(score)

func _check_sign(ActiveSign, guess):
	return ActiveSign.to_lower() == guess.to_lower()

func _on_Button_pressed():
	var prompt = find_child("Prompt")
	var guess = prompt.text
	print(guess)
	print(_check_sign(ActiveSign, guess))
	if(_check_sign(ActiveSign, guess)):
		Score += 1
		_set_score_text(Score)
		_set_instruction_text("Correct! Guess again.")
	else:
		_set_instruction_text("Incorrect. The correct answer was " + ActiveSign + ". Try again.")
		
	_on_NewRound()

#func _on_LetterTypingPractice_gui_input(event):
#	if event is InputEventKey and event.scancode == KEY_ENTER:
#		_on_Button_pressed()
