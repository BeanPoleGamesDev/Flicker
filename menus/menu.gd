extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_Exit_pressed():
	get_tree().quit()


func _on_Play_pressed():
	get_tree().change_scene("res://game/Game.tscn")
