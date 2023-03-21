extends Node

@onready var move_right_com = load("res://Examples/ExampleCommands/MoveRightCommand.tscn")

func _ready():
	var new = move_right_com.instantiate()
	new.time = .5
	new.move_target = $Player
	$Timeline.add_command(new)
	
	new = move_right_com.instantiate()
	new.move_target = $Player
	new.time = 1.0
	$Timeline.add_command(new)
	
#	new = move_right_com.instantiate()
#	new.time = 3
#	new.track = 1
#	$Timeline.add_command(new)
