class_name Command
extends Node2D

## Base node for Commands
##
## Placed on the timeline at a specified time, when the timeline reaches that point the command is executed
##

## The Command icon to display on the timeline
@export var icon_texture: Texture2D = PlaceholderTexture2D.new()

## The time this Command will run on the timeline
@export var time: float

## Set to true once the Command is executed.
@export var has_run := false

func _ready():
	add_to_group("timeline_command")
	$IconSprite.texture = icon_texture
	if icon_texture is PlaceholderTexture2D:
		$IconSprite.texture.size = Vector2(32,32)

func run(_args: Array = []):
	pass
	
func reset():
	has_run = false
