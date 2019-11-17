extends Node

var timer
var answer = []
var quiz = ["C"]
export(float) var bpm = 98.0
onready var  player_note_player = $PlayerNotePlayer
onready var  robot_note_player = $RobotNotePlayer
onready var two_bar_sec = (8/bpm)*60

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
	var SM = $SpritesManager
	var b = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
	for i in range(1):
		var p = randi()%12
		var k = randi()%2
		if !(b[p] in quiz):
			quiz.append(b[p])
			player_note_player.play_note(b[p])
	timer = get_node("Timer")
	timer.set_wait_time(two_bar_sec)
	timer.start()
	
	if randi()%2:
		$CorrectAnswer.text = str('Press the note: ', quiz)
	else:
		$CorrectAnswer.text = str('Can you guess?: [?]')
func evaluation(answer):
	if len(answer) != len(quiz):
		return false
	for q in quiz:
		if !(q in answer):
			 return false
	return true

func _on_Timer_timeout():
	if evaluation(answer):
		$Score.text = str(int($Score.text) + 1)
	$Label.text = str(0)
	$CorrectAnswer.text = str('Correct Answer: ', quiz)
	$YourAnswer.text = str('Your Answer: ', answer)
	quiz()
	timer.set_wait_time(two_bar_sec)
	timer.start()



func _on_PlayerNotePlayer_note_played(note):
	answer.append(note)
