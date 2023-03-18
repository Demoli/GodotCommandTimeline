extends Node


@onready var command = load("res://Command.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var new = command.instantiate()
	new.time = 1
	$Timeline.add_command(new)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
