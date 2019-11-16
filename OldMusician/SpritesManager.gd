extends Node

onready var note_to_sprite = {"C":$Sprite_C, "C#":$Sprite_Csharp, "D":$Sprite_D, "D#":$Sprite_Dsharp, "E":$Sprite_E, "F":$Sprite_F,
							"F#":$Sprite_Fsharp, "G":$Sprite_G, "G#":$Sprite_Gsharp, "A":$Sprite_A, "A#":$Sprite_Asharp, "B":$Sprite_B}

var notes = []
var initial_notes_position = {}

func _ready():
	for sprite in get_children():
		initial_notes_position[sprite.name] = sprite.position

func _on_NotePlayer_note_played(note):
	if note_to_sprite[note] in notes:
		return
	var tw = $Tween
	var _ini_pos = initial_notes_position[note_to_sprite[note].name]
	notes.append(note_to_sprite[note])
	tw.interpolate_property(note_to_sprite[note], "position", 
	_ini_pos, _ini_pos + Vector2(0,-640), 2, Tween.TRANS_QUAD, Tween.EASE_IN) 
	tw.start()

func _on_Tween_tween_completed(object, nodePath):
	object.position = initial_notes_position[object.name]
	notes.erase(object)
