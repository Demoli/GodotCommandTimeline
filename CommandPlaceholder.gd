class_name CommandPlaceholder
extends Area2D

## Base node for Command Placeholders
## 
## Area2D scene that will be added to the timeline for each available command step[br]
## This acts as a target for Commands to be added to during runtime.
##

## The time that the placeholder occupies on the Timeline.[br]
## When a command is added to a placeholder the time can be set from the CommandPlaceholder to the Command
@export var time_position := 0.0
