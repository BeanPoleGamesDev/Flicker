extends Node2D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event.is_action('ui_exit'):
		get_tree().quit()

