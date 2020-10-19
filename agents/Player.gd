extends KinematicBody2D

const ANIM_WALK_PREFIX = '%s_walk'


export var speed := 5000

var walking = false
var compass = Vector2.ZERO

onready var flashlight = $Flashlight
onready var input = $PlayerInput
onready var anim = $Anim


func _physics_process(delta):
	move_and_slide(input.movement * speed * delta)

func _on_MouseInput_rotate(angle):
	flashlight.rotation = angle
	

func _on_PlayerInput_pressed(action):
	walking = true
	anim.play(get_anim_name())

func _on_PlayerInput_turn(compass):
	anim.play(get_anim_name())


func _on_PlayerInput_all_released():
	walking = false

	anim.play(get_anim_name())

func _on_PlayerInput_released(action):
	pass


func get_anim_name():
	if walking:
		return ANIM_WALK_PREFIX % get_anim_prefix()
	else:
		return get_anim_prefix()

func get_anim_prefix()->String:
	var out = 'down'
	if input.compass.x == -1:
		return 'left'
	if input.compass.x == 1:
		return 'right'
	if input.compass.y == -1:
		return 'up'
	if input.compass.y == 1:
		return 'down'
	return 'down'





func _on_Hitbox_area_entered(area):
	get_tree().change_scene("res://menus/GameOver.tscn")


func _on_SightBox_area_entered(area):
	pass # Replace with function body.
