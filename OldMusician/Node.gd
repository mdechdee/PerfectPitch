extends Node
onready var P1 = $C
onready var P2 = $"C#"
onready var P3 = $D
onready var P4 = $"D#"
onready var P5 = $E
onready var P6 = $F
onready var P7 = $"F#"
onready var P8 = $G
onready var P9 = $"G#"
onready var P10 = $A
onready var P11 = $"A#"
onready var P12 = $B

export(bool) var is_robot = false

signal note_played(note)
onready var note_to_node = {"C":P1, "C#":P2, "D":P3, "D#":P4, "E":P5, "F":P6,
							"F#":P7, "G":P8, "G#":P9, "A":P10, "A#":P11, "B":P12}
onready var note_to_sprite = {"C":$Sprite_C, "C#":$Sprite_Csharp, "D":$Sprite_D, "D#":$Sprite_Dsharp, "E":$Sprite_E, "F":$Sprite_F,
							"F#":$Sprite_Fsharp, "G":$Sprite_G, "G#":$Sprite_Gsharp, "A":$Sprite_A, "A#":$Sprite_Asharp, "B":$Sprite_B}

func play_note(note):
	note_to_node[note].play()

func get_note_length():
	return P1.stream.get_length()

var movement = Vector2(0, 5)
var timer
var notes = []
var answer = []

var quiz = ["C"]

signal timer_end

func _input(event):
	if is_robot:
		return
	if event.is_action_pressed("note"):
		for key in note_to_node.keys():
			if Input.is_action_just_pressed(key):
				note_to_node[key].play()
				emit_signal("note_played", key)
				print('key', key)
				if key in notes:
					return
				notes.append(note_to_sprite[key])
				answer.append(key)

	if event.is_action_released("note"):
		var t = get_node("Tween")
		for key in note_to_node.keys():
			if Input.is_action_just_released(key):
				t.interpolate_property(note_to_node[key], "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		t.start()

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
	if len(notes) == 0:
		return
	#var notes = [$C, $E, $G]
	#var note = notes[randi() % 5]
	print(notes)
	for note in notes:
		print('note', note)
		#print(note.get_position().y)
		if note.get_position().y < -560:
			note.set_position(Vector2(note.get_position().x, 0))
			notes.remove(0)
		note.position -= movement
	#if (note.get_position()):
	#    note.position = 500
	
func quiz():
	quiz = []
	var a = [P1, P2, P3, P4, P5, P6, P7, P8, P9, P10, P11, P12]
	var b = ["C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"]
	for i in range(1):
		var p = randi()%12
		if !(b[p] in quiz):
			quiz.append(b[p])
			a[p].play()
	print(quiz)

func evaluation(answer):
	if len(answer) != len(quiz):
		return false
	for q in quiz:
		if !(q in answer):
			 return false
	return true

func _wait(seconds):
	self._create_timer(self, seconds, true, "_emit_timer_end_signal")
	yield(self,"timer_end")

func _emit_timer_end_signal():
	emit_signal("timer_end")

func _create_timer(object_target, float_wait_time, bool_is_oneshot, string_function):
	timer = Timer.new()
	timer.set_one_shot(bool_is_oneshot)
	timer.set_timer_process_mode(0)
	timer.set_wait_time(float_wait_time)
	timer.connect("timeout", object_target, string_function)
	self.add_child(timer)
	timer.start()
