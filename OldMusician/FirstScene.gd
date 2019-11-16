extends Node2D

var movement = Vector2(0, 2)
var timer

func _ready():
    randomize()
    var texture = load("res://assets/speaker.png")
    $Speaker.texture = texture

    timer = get_node("Timer")
    timer.set_wait_time(5)
    timer.connect("timeout", self, "_on_Timer_timeout")
    timer.start()

func _process(delta):
    var notes = [$C, $E, $G]
    #var note = notes[randi() % 5]
    for note in notes:
        #print(note.get_position().y)
        if note.get_position().y < -560:
            note.set_position(Vector2(note.get_position().x, 0))
        note.position -= movement
    #if (note.get_position()):
    #    note.position = 500
    if (timer.get_time_left() < 1.0):
        timer.stop()
    if (timer.get_time_left() >= 0):
        $Label.text = str(floor(timer.get_time_left()))
