extends Node

var timer
var answer = []
var quiz = ["C"]
onready var  note_player = $NotePlayer

signal timer_end

var started

func _ready():
	quiz()

func _process(delta):
	if (timer.get_time_left() < 1.0):
		if evaluation(answer):
			$Score.text = str(int($Score.text) + 1)
		$Label.text = str(0)
		timer.stop()
		
		$CorrectAnswer.text = str('Correct Answer: ', quiz)
		$YourAnswer.text = str('Your Answer: ', answer)
		
		quiz()
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
			note_player.play_note(b[p])
	timer = get_node("Timer")
	timer.set_wait_time(6)
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
	$YourAnswer.text = str('Your Answer: ', answer)
	if len(answer) > 0:
		$CorrectAnswer.text = str('Correct Answer: ', [])

