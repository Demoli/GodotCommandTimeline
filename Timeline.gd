extends Control

enum CommandAlign{LEFT,RIGHT,CENTER}

## Tick speed in seconds
@export var tick_speed: float = 1

# Total tick time in seconds
@export var max_time: float = 12.00

@export var playing: bool = false

@export var commands: Array[Command] = []

#@export var command_alignment = CommandAlign.CENTER

## How many commands can be executed in 1 tick
## e.g. a tick of 1 and step of 1 will execute the first command at 1 second, the next at 2 seconds
## a tick of 1 and a step of 2 will execute the first command at 0.5 seconds, the next at 1 second, and so on
@export var command_step: float = .5

## If treu you can place a command at zero seconds, then the rest willow follow the command step
@export var allow_command_at_zero := true

@onready var placeholder = load("res://CommandPlaceholder.tscn")

var tick: float = 0.0
var time_start: float

# Called when the node enters the scene tree for the first time.
func _ready():
	time_start = Time.get_unix_time_from_system()

	$ProgressBar.value = 0
	$ProgressBar.max_value = max_time
	
	_init_placeholders()

func _unhandled_key_input(event):
	if event.is_action_pressed("play_pause"):
		playing = not playing
	if event.is_action_pressed("stop"):
		stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if playing:
		tick += tick_speed * delta
		$ProgressBar.value = tick
		
		_process_commands()

func _process_commands():
	var runnable = commands.filter(
		func(command): 
			if command.time == tick:
				command.run()
	)

func play():
	playing = true

func pause():
	playing = false
	
func stop():
	playing = false
	$ProgressBar.value = 0
	tick = 0

func get_running_time():
	var time_now = Time.get_unix_time_from_system()
	var time_elapsed = time_now - time_start
	
	return time_elapsed

func _init_placeholders():
	
	var width = get_rect().size.x
	var x_per_tick = width / max_time
	var command_offset = (command_step / tick_speed)
	
	var start = 0 if allow_command_at_zero else 1
	
	for time in range(start, (max_time / command_step) + 1):
		var command_pos = Vector2((x_per_tick * time) * command_offset, 25)
		var new_place = placeholder.instantiate()
		new_place.position = command_pos
		new_place.time_position = (time * command_step)
		$Tracks/Track.add_child(new_place)
