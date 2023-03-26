class_name Timeline
extends BoxContainer

## Timeline node
##
## A timeline control that can accept be played, paused and reset.
## Command objects can be added to the timeline and will execute when the timeline reaches that time.[br]
##

signal command_added

@export var playing := false

func _ready():
	add_to_group("timeline")

func add_command(command: Command):
	get_tree().get_nodes_in_group("track")[command.track].add_command(command)
	
func play():
	get_tree().call_group("tracks", "play")

func pause():
	get_tree().call_group("tracks", "pause")
	
func stop():
	get_tree().call_group("tracks", "stop")

func reset():
	get_tree().call_group("tracks", "reset")
	get_tree().call_group("timeline_command", "queue_free")

func _unhandled_key_input(event):
	if event.is_action_pressed("play_pause"):
		if not playing:
			get_tree().call_group("tracks", "play")
		else:
			get_tree().call_group("tracks", "pause")
	if event.is_action_pressed("stop"):
		get_tree().call_group("tracks", "stop")


func _on_track_command_added(command):
	emit_signal("command_added", command)
