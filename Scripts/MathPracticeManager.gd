extends Node

var Signs = {
	1:"1", 2:"2", 3:"3", 4:"4", 5:"5", 6:"6", 7:"7", 8:"8", 9:"9", 10:"10"
}

var Operations = {
	1:"Plus", 2:"Minus"
}
	
var ActiveSign1
var ActiveSign2
var Operation
var answer = 0
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
	answer = _create_problem()
	
func _create_problem():
	var signs = Signs.values()
	ActiveSign1 = signs[randi() % signs.size()]
	var operations = Operations.values()
	Operation = operations[randi() % operations.size()]
	
	_switch_image("Sign1", ActiveSign1)
	
	if Operation == "Plus":
		_set_operation_text("+")
		ActiveSign2 = signs[randi() % signs.size()]
	else:
		_set_operation_text("-")
		ActiveSign2 = signs[randi() % int(ActiveSign1)]
	
	_switch_image("Sign2", ActiveSign2)
	
	if Operation == "Plus":
		return int(ActiveSign1) + int(ActiveSign2)
	else:
		return int(ActiveSign1) - int(ActiveSign2)

func _switch_image(nodeName, signChar):
	var signContainer = find_child(nodeName);
	signContainer.texture = load("res://Images/Signs/" + signChar + ".png")
	
func _set_instruction_text(newInstruction):
	var instructionContainer = find_child("Instruction")
	instructionContainer.text = newInstruction
	
func _set_operation_text(newOperation):
	var operationContainer = find_child("Operation")
	operationContainer.text = newOperation
	
func _set_score_text(score):
	var scoreContainer = find_child("Score")
	scoreContainer.text = "Score: " + String(score)

func _check_sign(answer, guess):
	return int(answer) == int(guess)

func _on_Button_pressed():
	var prompt = find_child("Prompt")
	var guess = prompt.text
	print(guess)
	print(_check_sign(answer, guess))
	if(_check_sign(answer, guess)):
		Score += 1
		_set_score_text(Score)
		_set_instruction_text("Correct! Guess again.")
	else:
		_set_instruction_text("Incorrect. The correct answer was " + String(answer) + ". Try again.")
		
	_on_NewRound()

func _on_MenuButton_pressed(extra_arg_0):
	get_tree().change_scene_to_file("res://Scenes/" + extra_arg_0 + ".tscn")
