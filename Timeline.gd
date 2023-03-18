extends Control

## Tick speed in seconds
@export var tick_speed: float = 1.00

# Total tick time in seconds
@export var max_time: float = 12.00

var tick: float = 0.0
var time_start: float

# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = Time.get_unix_time_from_system()

	$ProgressBar.value = 0
	$ProgressBar.max_value = max_time
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tick += tick_speed * delta
	$ProgressBar.value = tick
#	print(floor(tick),":",floor(get_running_time()))

func get_running_time():
	var time_now = Time.get_unix_time_from_system()
	var time_elapsed = time_now - time_start
	
	return time_elapsed
