class_name Command
extends Area2D

## Base node for Commands
##
## Placed on the timeline at a specified time, when the timeline reaches that point the command is executed
##

## The time this Command will run on the timeline
@export var time: float

## Set to true once the Command is executed.
@export var has_run := false

@export var draggable := false

## The timeline track index to add the command to (0 indexed)
@export var track := 0

## A material that will be added to the command to show that it is running
@export var running_command_material: Material = load("res://addons/commandtimeline/RunningCommandMaterial.tres")

@onready var timeline = get_tree().get_first_node_in_group("timeline")

var placeholder_area: Area2D

var mouse_over := false

func _ready():
	add_to_group("timeline_command")
	connect("mouse_entered", Callable(func(): mouse_over = true))
	connect("mouse_exited", Callable(func(): mouse_over = false))

func run():
	$Sprite2D.material = running_command_material
	
func reset():
	has_run = false
	$Sprite2D.material
	
func _input(event):
	if draggable and event.is_action_released("drop_command"):
		queue_free()
	if draggable and event.is_action_released("pick_place_command"):
		var place = _get_overlapping_palceholder()
		if place:
			track = place.track
			place_command(place)
	elif not draggable and mouse_over and event.is_action_released("pick_place_command"):
		timeline.remove_command(self)
		get_parent().remove_child(self)
		timeline.get_parent().add_child(self)
		draggable = true

func place_command(area: CommandPlaceholder):
	get_parent().remove_child(self)
	
	time = area.time_position
	timeline.add_command(self)
	draggable = false
	
func _physics_process(_delta):
	if not draggable:
		return
	
	global_position = get_global_mouse_position()
	
func _get_overlapping_palceholder():
	var areas = get_overlapping_areas()
	for area in areas:
		
		if area.get_parent() is CommandPlaceholder:
			return area.get_parent()
	return null

func _on_mouse_entered():
	mouse_over = true

func _on_mouse_exited():
	mouse_over = false
