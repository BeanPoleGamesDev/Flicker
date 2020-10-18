extends Node

var position = Vector2.ZERO
var motion = Vector2.ZERO
var angle = Vector2.ZERO

onready var player = get_parent()

func _input(event):
	if event is InputEventMouseMotion:
		
		motion = event.position - mouse_position
		
		

		mouse_position = event.position
