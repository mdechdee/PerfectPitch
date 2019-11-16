extends Node
onready var P1 = $AudioStreamPlayer 
onready var P2 = $AudioStreamPlayer2

func _input(event):
	if event.is_action_pressed("ui_down"):
		P1.play()
	if event.is_action_pressed("ui_up"):
		P2.play()