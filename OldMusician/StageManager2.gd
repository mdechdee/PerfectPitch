extends Node

var timer
var answer = []
var quiz = ["C"]
export(float) var bpm = 98.0
onready var  player_note_player = $PlayerNotePlayer
onready var  robot_note_player = $RobotNotePlayer
onready var two_bar_sec = (8/bpm)*60
onready var pop_up = $PopupPanel

onready var no
signal timer_end

var started

func _ready():
	quiz()

func _process(delta):
	if (timer.get_time_left() >= 0):
		$Label.text = str(floor(timer.get_time_left()))

func quiz():
	quiz = []
	answer = []
	var b = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
	for i in range(1):
		var p = randi()%12
		if !(b[p] in quiz):
			quiz.append(b[p])
			pop_up.get_node("Label").text = b[p]
			pop_up.show()
	
	timer = get_node("Timer")
	timer.set_wait_time(two_bar_sec)
	timer.start()

func evaluation(answer):
	if len(answer) != len(quiz):
		return false
	for q in quiz:
		if !(q in answer):
			 return false
	return true


func _on_NotePlayer_note_played(note):
	answer.append(note)


func _on_Timer_timeout():
	var SM = $SpritesManager
	if evaluation(answer):
		$Score.text = str(int($Score.text) + 1)
	else:
		$YourAnswer.rect_global_position = SM.note_to_sprite[answer[0]].get_node("ColorRect").rect_global_position
	print(SM.note_to_sprite[quiz[0]].get_node("ColorRect").rect_global_position)
	$CorrectAnswer.rect_global_position = SM.note_to_sprite[quiz[0]].get_node("ColorRect").rect_global_position
	$Label.text = str(0)
	quiz()
	timer.set_wait_time(two_bar_sec)
	timer.start()
