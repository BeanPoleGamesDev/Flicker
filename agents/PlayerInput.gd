extends Node


var mouse_motion = Vector2.ZERO

var angle = Vector2.ZERO
var direction = Vector2.ZERO
var movement = Vector2.ZERO
var compass = Vector2.ZERO
var last_com = Vector2.ZERO

var actions = {
	'ui_up': 0,
	'ui_down': 0,
	'ui_left': 0,
	'ui_right': 0
}


export var smooth := 0.99

signal rotate(angle)
signal pressed(action)
signal released(action)
signal turn(compass)
signal all_released()

func _input(event):
	
	if event is InputEventMouseMotion:
		
		mouse_motion = mouse_motion*smooth + event.relative
		angle = mouse_motion.angle()
		compass = mouse_motion.normalized().round()
		if compass.y != 0 && compass.x !=0:
			compass.y = 0
		if last_com != compass:
			emit_signal('turn', compass)

		last_com = compass

		emit_signal("rotate", angle)
		return
	
	for action in actions:
		if event.is_action_pressed(action):
			actions[action] = 1	
			emit_signal("pressed",action)
		elif event.is_action_released(action):
			actions[action] = 0
			emit_signal("released",action)
			
	
	movement = Vector2(
		actions['ui_right'] - actions['ui_left'],
		actions['ui_down'] - actions['ui_up']
	)
	if movement.x == 0 && movement.y == 0:
		emit_signal('all_released')
