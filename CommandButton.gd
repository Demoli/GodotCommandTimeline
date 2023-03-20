@tool
class_name CommandButton
extends TextureButton

@export var command: PackedScene

func _get_configuration_warnings():
	pass

func _ready():
	command = load("res://Examples/ExampleCommands/MoveRightCommand.tscn")

func _on_pressed():
	var new = command.instantiate() as Command
	new.position = get_global_mouse_position()
	new.draggable = true
	get_tree().root.add_child(new)
