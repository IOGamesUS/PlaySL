extends Node

# Change to words
var Signs = {
	1:"A", 2:"B", 3:"C", 4:"D", 5:"E", 6:"F", 7:"G", 8:"H", 9:"I", 10:"J", 11:"K", 12:"L", 13:"M", 
	14:"N", 15:"O", 16:"P", 17:"Q", 18:"R", 19:"S", 20:"T", 21:"U", 22:"V", 23:"W", 24:"X", 25:"Y", 26:"Z"}
	
var Score = 0
var ActiveSign

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
	var VideoSign = find_child("AnimatedSprite2D")
	VideoSign.play()
	
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

func _on_MenuButton_pressed(extra_arg_0: String) ->void :
	get_tree().change_scene_to_file("res://Scenes/" + extra_arg_0 + ".tscn")
