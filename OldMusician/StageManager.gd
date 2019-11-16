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

func _ready():
	quiz()
	timer = get_node("Timer")
	timer.set_wait_time(two_bar_sec)
	timer.connect("timeout", self, "_on_Timer_timeout")
	quiz()
	timer.start()

func _process(delta):
	if (timer.get_time_left() < 1.0):
		if evaluation(answer):
			$Score.text = str(int($Score.text) + 1)
		$Label.text = str(0)
		timer.stop()
		
		$CorrectAnswer.text = str('Correct Answer: ', quiz)
		$YourAnswer.text = str('Your Answer: ', answer)
		
		quiz()
		timer = get_node("Timer")
		timer.set_wait_time(two_bar_sec)
		#timer.connect("timeout", self, "_on_Timer_timeout")
		timer.start()
	if (timer.get_time_left() >= 0):
		$Label.text = str(floor(timer.get_time_left()))

func quiz():
	quiz = []
	answer = []
	var SM = $SpritesManager
	for note in SM.note_to_sprite.keys():
		SM.note_to_sprite[note].set_position(Vector2(SM.note_to_sprite[note].get_position().x, 0))
	var b = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
	for i in range(1):
		var p = randi()%12
		if !(b[p] in quiz):
			quiz.append(b[p])
			robot_note_player.play_note(b[p])
	print(quiz)

func evaluation(answer):
	if len(answer) != len(quiz):
		return false
	for q in quiz:
		if !(q in answer):
			 return false
	return true


func _on_NotePlayer_note_played(note):
	answer.append(note)
