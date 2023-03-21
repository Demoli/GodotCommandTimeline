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

var placeholder_area: Area2D

func _ready():
	add_to_group("timeline_command")
#	connect("area_entered", Callable(self, "_on_area_2d_area_entered"))
#	connect("area_exited", Callable(self, "_on_area_2d_area_exited"))

func run(_args: Array = []):
	pass
	
func reset():
	has_run = false
	
func _input(event):
	if draggable and event.is_action_released("drop_command"):
		queue_free()
	if draggable and event.is_action_released("place_command"):
		var place = _get_overlapping_palceholder()
		if place:
			track = place.track
			place_command(place)

#func _on_area_2d_area_entered(area):
#	if area is CommandPlaceholder:
#		placeholder_area = area
#		print("Entered: %s " % area.name)
#
#func _on_area_2d_area_exited(area):
#	if area is CommandPlaceholder:
#		placeholder_area = null
#		print("Left: %s " % area.name)

func place_command(area: Area2D):
	get_parent().remove_child(self)
	
	time = area.time_position
	var timeline: Timeline = area.get_node("../../../")
	timeline.add_command(self)
	draggable = false
	
func _physics_process(_delta):
	if not draggable:
		return
	
	global_position = get_global_mouse_position()
	
func _get_overlapping_palceholder():
	var areas = get_overlapping_areas()
	for area in areas:
		if area is CommandPlaceholder:
			return area
	return null
