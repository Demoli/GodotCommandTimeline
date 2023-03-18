class_name Command
extends Node2D

## Icon texture
@export var icon_texture: Texture2D = PlaceholderTexture2D.new()

## The icon size in pixels
@export var icon_size: Vector2 = Vector2(32,32)

## The time this command will run on the timeline
@export var time: float

@export var has_run := false

func _ready():
	$IconSprite.texture = icon_texture
	$IconSprite.texture.size = icon_size

func run(args: Array = []):
	pass
