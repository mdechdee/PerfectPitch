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

signal note_C_played
signal note_C_sharp_played
signal note_D_played
signal note_D_sharp_played
signal note_E_played
signal note_F_played
signal note_F_sharp_played
signal note_G_played
signal note_G_sharp_played
signal note_A_played
signal note_A_sharp_played
signal note_B_played

var movement = Vector2(0, 5)
var timer
var notes = []
var answer = []

signal timer_end

func _input(event):
	if event.is_action_pressed("note"):
		if Input.is_action_just_pressed("C"):
			P1.play()
			emit_signal("note_C_played")
			if $E in notes:
				return
			notes.append($Sprite_C)
			answer.append("C")
		elif Input.is_action_just_pressed("C#"):
			P2.play()
			emit_signal("note_C_sharp_played")
		elif Input.is_action_just_pressed("D"):
			P3.play()
			emit_signal("note_D_played")
			if $E in notes:
				return
			notes.append($Sprite_D)
			answer.append("D")
		elif Input.is_action_just_pressed("D#"):
			P4.play()
			emit_signal("note_D_sharp_played")
		elif Input.is_action_just_pressed("E"):
			P5.play()
			emit_signal("note_E_played")
			if $E in notes:
				return
			notes.append($Sprite_E)
			answer.append("E")
		elif Input.is_action_just_pressed("F"):
			P6.play()
			emit_signal("note_F_played")
			if $E in notes:
				return
			notes.append($Sprite_F)
			answer.append("F")
		elif Input.is_action_just_pressed("F#"):
			P7.play()
			emit_signal("note_F#_played")
		elif Input.is_action_just_pressed("G"):
			P8.play()
			emit_signal("note_G_played")
			if $E in notes:
				return
			notes.append($Sprite_G)
			answer.append("G")
		elif Input.is_action_just_pressed("G#"):
			P9.play()
			emit_signal("note_G_sharp_played")
		elif Input.is_action_just_pressed("A"):
			P10.play()
			emit_signal("note_A_played")
			if $E in notes:
				return
			notes.append($A)
			answer.append("A")
		elif Input.is_action_just_pressed("A#"):
			P11.play()
			emit_signal("note_A_sharp_played")
		elif Input.is_action_just_pressed("B"):
			P12.play()
			emit_signal("note_B_played")
			if $E in notes:
				return
			notes.append($B)
			answer.append("B")

	if event.is_action_released("note"):
		var t = get_node("Tween")
		if Input.is_action_just_released("C"):
			t.interpolate_property(P1, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("C#"):
			t.interpolate_property(P2, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("D"):
			t.interpolate_property(P3, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("D#"):
			t.interpolate_property(P4, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("E"):
			t.interpolate_property(P5, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("F"):
			t.interpolate_property(P6, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("F#"):
			t.interpolate_property(P7, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("G"):
			t.interpolate_property(P8, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("G#"):
			t.interpolate_property(P9, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("A"):
			t.interpolate_property(P10, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("A#"):
			t.interpolate_property(P11, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		elif Input.is_action_just_released("B"):
			t.interpolate_property(P12, "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
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
		if "C" in answer and "E" in answer and "G" in answer:
			$Score.text = str(int($Score.text) + 1)
		$Label.text = str(0)
		timer.stop()
		
		#_wait(10)
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
	for note in notes:
		#print(note.get_position().y)
		if note.get_position().y < -560:
			note.set_position(Vector2(note.get_position().x, 0))
			notes.remove(0)
		note.position -= movement
	#if (note.get_position()):
	#    note.position = 500
	
func quiz():
	P1.play()
	P5.play()
	P8.play()

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
