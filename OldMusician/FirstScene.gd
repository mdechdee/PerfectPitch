extends Node2D

onready var P = $AudioStreamPlayer
onready var length = P.stream.get_length()
onready var length_per_note = length/12
onready var player_instrument = $PlayerInstrumentPlayer
onready var robot_instrument = $RobotInstrumentPlayer
var movement = Vector2(0, 5)
var timer
var notes = []
var answer = []

signal timer_end

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
    robot_instrument.play_note("C")
    robot_instrument.play_note("E")
    robot_instrument.play_note("G")


func _on_PlayerInstrumentPlayer_note_played(note):
	if get_node(note) in notes:
		return
	notes.append(get_node(note))
	answer.append(note)
