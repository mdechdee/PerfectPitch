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


func play_note(note):
	note_to_node[note].play()

func get_note_length():
	return P1.stream.get_length()

func _input(event):
	if is_robot:
		return
	if event.is_action_pressed("note"):
		for key in note_to_node.keys():
			if Input.is_action_just_pressed(key):
				note_to_node[key].play()
				emit_signal("note_played", key)
				

	if event.is_action_released("note"):
		var t = get_node("Tween")
		for key in note_to_node.keys():
			if Input.is_action_just_released(key):
				t.interpolate_property(note_to_node[key], "volume_db", 0, -4, 1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		t.start()
