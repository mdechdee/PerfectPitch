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

func _input(event):
	if event.is_action_pressed("note"):
		if Input.is_action_just_pressed("C"):
			P1.play()
			emit_signal("note_C_played")
		elif Input.is_action_just_pressed("C#"):
			P2.play()
			emit_signal("note_C_sharp_played")
		elif Input.is_action_just_pressed("D"):
			P3.play()
			emit_signal("note_D_played")
		elif Input.is_action_just_pressed("D#"):
			P4.play()
			emit_signal("note_D_sharp_played")
		elif Input.is_action_just_pressed("E"):
			P5.play()
			emit_signal("note_E_played")
		elif Input.is_action_just_pressed("F"):
			P6.play()
			emit_signal("note_F_played")
		elif Input.is_action_just_pressed("F#"):
			P7.play()
			emit_signal("note_F#_played")
		elif Input.is_action_just_pressed("G"):
			P8.play()
			emit_signal("note_G_played")
		elif Input.is_action_just_pressed("G#"):
			P9.play()
			emit_signal("note_G_sharp_played")
		elif Input.is_action_just_pressed("A"):
			P10.play()
			emit_signal("note_A_played")
		elif Input.is_action_just_pressed("A#"):
			P11.play()
			emit_signal("note_A_sharp_played")
		elif Input.is_action_just_pressed("B"):
			P12.play()
			emit_signal("note_B_played")

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

