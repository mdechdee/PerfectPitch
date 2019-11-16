extends Node

var timer
var answer = []
var quiz = ["C"]
onready var  note_player = $NotePlayer

signal timer_end

func _ready():
	#randomize()
	#var texture = load("res://assets/speaker.png")
	#$Speaker.texture = texture
	quiz()
	timer = get_node("Timer")
	timer.set_wait_time(6)
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start()

func _process(delta):
	if (timer.get_time_left() < 1.0):
		print(answer)
		#if "C" in answer and "E" in answer and "G" in answer:
		if evaluation(answer):
			$Score.text = str(int($Score.text) + 1)
		$Label.text = str(0)
		timer.stop()
		
		#_wait(10)
		$CorrectAnswer.text = str('Correct Answer: ', quiz)
		$YourAnswer.text = str('Your Answer: ', answer)
		
		answer = []
		quiz()
		timer = get_node("Timer")
		timer.set_wait_time(6)
		#timer.connect("timeout", self, "_on_Timer_timeout")
		timer.start()
	if (timer.get_time_left() >= 0):
		$Label.text = str(floor(timer.get_time_left()))

	
func quiz():
	quiz = []
	var b = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
	for i in range(1):
		var p = randi()%12
		if !(b[p] in quiz):
			quiz.append(b[p])
			note_player.play_note(b[p])
	print(quiz)

func evaluation(answer):
	if len(answer) != len(quiz):
		return false
	for q in quiz:
		if !(q in answer):
			 return false
	return true


func _on_NotePlayer_note_played(note):
	print('key', note)
	answer.append(note)
