extends "res://Command.gd"

@export var move_target: Node2D

func _ready():
	move_target = get_tree().root.get_node("/root/ExampleScene/Player")

func run(_args: Array = []):
	var tween = get_tree().create_tween()
	tween.tween_property(
		move_target,
		"position",
		move_target.position + Vector2.RIGHT * 64,
		.5
	)
