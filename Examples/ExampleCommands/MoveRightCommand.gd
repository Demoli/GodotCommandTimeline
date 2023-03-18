extends "res://Command.gd"

@export var move_target: Node2D

func run(args: Array = []):
	move_target.position.x += 64
