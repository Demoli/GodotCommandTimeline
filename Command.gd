class_name Command
extends Node2D

## Icon texture
@export var icon_texture: Texture2D = PlaceholderTexture2D.new()

## The time this command will run on the timeline
@export var time: float

@export var has_run := false

func _ready():
	add_to_group("timeline_command")
	$IconSprite.texture = icon_texture
	if icon_texture is PlaceholderTexture2D:
		$IconSprite.texture.size = Vector2(32,32)

func run(args: Array = []):
	pass
	
func reset():
	has_run = false
