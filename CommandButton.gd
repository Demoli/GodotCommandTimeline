class_name CommandButton
extends TextureButton

@export var command: Resource
@export var draggable := false
var placeholder_area: Area2D

func _ready():
	command = load("res://Examples/ExampleCommands/MoveRightCommand.tscn")

func _physics_process(_delta):
	if not draggable:
		return
	
	global_position = get_global_mouse_position() - get_rect().size / 2

func _on_pressed():
	var new = duplicate()
	new.draggable = true
	new.disabled = true
	get_tree().root.add_child(new)	
	
func _input(event):
	if draggable and event.is_action_released("drop_command"):
		queue_free()
	if placeholder_area and event.is_action_released("place_command"):
		place_command(placeholder_area)

func _on_area_2d_area_entered(area):
	if area is CommandPlaceholder:
		placeholder_area = area
		print(placeholder_area)

func _on_area_2d_area_exited(area):
	if area is CommandPlaceholder:
		placeholder_area = null

func place_command(area: CommandPlaceholder):
	var new_command = command.instantiate()
	new_command.time = area.time_position
	var timeline: Timeline = area.get_parent().get_owner()
	timeline.add_command(new_command)
	queue_free()
