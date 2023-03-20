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

var placeholder_area: Area2D

func _ready():
	add_to_group("timeline_command")
	connect("area_entered", Callable(self, "_on_area_2d_area_entered"))
	connect("area_exited", Callable(self, "_on_area_2d_area_exited"))

func run(_args: Array = []):
	pass
	
func reset():
	has_run = false
	
func _input(event):
	if draggable and event.is_action_released("drop_command"):
		queue_free()
	if draggable and placeholder_area and event.is_action_released("place_command"):
		place_command(placeholder_area)

func _on_area_2d_area_entered(area):
	if area is CommandPlaceholder:
		placeholder_area = area

func _on_area_2d_area_exited(area):
	if area is CommandPlaceholder:
		placeholder_area = null

func place_command(area: CommandPlaceholder):
	get_parent().remove_child(self)
	
	time = area.time_position
	var timeline: Timeline = area.get_parent().get_owner()
	
	timeline.add_command(self)
	draggable = false
	
func _physics_process(_delta):
	if not draggable:
		return
	
	global_position = get_global_mouse_position()
