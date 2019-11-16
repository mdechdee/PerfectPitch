extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var timer = $Timer
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


	timer = get_node("Timer")
	timer.set_wait_time( 2 )
	timer.connect("timeout", self, "_on_Timer_timeout")
	timer.start ()
	
func _on_Timer_timeout():
	timer.set_wait_time( 2 )
	timer.start()