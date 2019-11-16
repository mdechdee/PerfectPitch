extends Node

onready var note_to_sprite = {"C":$Sprite_C, "C#":$Sprite_Csharp, "D":$Sprite_D, "D#":$Sprite_Dsharp, "E":$Sprite_E, "F":$Sprite_F,
							"F#":$Sprite_Fsharp, "G":$Sprite_G, "G#":$Sprite_Gsharp, "A":$Sprite_A, "A#":$Sprite_Asharp, "B":$Sprite_B}
var notes = []
var movement = Vector2(0, 5)

func _process(delta):
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
	
func _on_NotePlayer_note_played(note):
	print('key', note)
	if note in notes:
		return
	notes.append(note_to_sprite[note])