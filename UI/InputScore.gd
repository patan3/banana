extends Control

onready var leaderBoard = preload("res://Template1_2dCharacter/src/Player/Leaderboard.tscn")

onready var submitButton = $Button
onready var textEdit = $TextEdit

func _ready():
	submitButton.connect("button_up", self, "submit_score")
	
func submit_score():
	textEdit.text.strip_edges()
	textEdit.text.strip_escapes()
	if textEdit.text.empty():
		return
	
	SilentWolf.Scores.persist_score(textEdit.text, Globals.score)
	
	var leaderBoardInstance = leaderBoard.instance()
	add_child(leaderBoardInstance)
