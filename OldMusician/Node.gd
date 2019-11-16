extends Node
onready var P = $AudioStreamPlayer
onready var length = P.stream.get_length()
onready var length_per_note = length/12

func _input(event):
	if Input.is_action_pressed("note"):
		var P1 = AudioStreamPlayer.new()
		var T = Timer.new()
		P1.stream = P.stream
		P1.add_child(T)
		T.connect("timeout",P1,"stop")
		T.start(length_per_note)
		add_child(P1)
		if event.is_action_pressed("C"):
			P1.play(0)
		elif event.is_action_pressed("C#"):
			P1.play(length_per_note)
		elif event.is_action_pressed("D"):
			P1.play(length_per_note*2)
		elif event.is_action_pressed("D#"):
			P1.play(length_per_note*3)
		elif event.is_action_pressed("E"):
			P1.play(length_per_note*4)
		elif event.is_action_pressed("F"):
			P1.play(length_per_note*5)
		elif event.is_action_pressed("F#"):
			P1.play(length_per_note*6)
		elif event.is_action_pressed("G"):
			P1.play(length_per_note*7)
		elif event.is_action_pressed("G#"):
			P1.play(length_per_note*8)
		elif event.is_action_pressed("A"):
			P1.play(length_per_note*9)
		elif event.is_action_pressed("A#"):
			P1.play(length_per_note*10)
		elif event.is_action_pressed("B"):
			P1.play(length_per_note*11)

