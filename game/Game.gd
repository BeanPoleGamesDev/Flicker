extends Node2D

onready var coins = $Coins

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _input(event):
	if event.is_action('ui_exit'):
		get_tree().quit()

func _on_coin_pickup(coin):
	coins.remove_child(coin)
	if coins.get_child_count() < 1:
		get_tree().change_scene("res://menus/Win.tscn")
