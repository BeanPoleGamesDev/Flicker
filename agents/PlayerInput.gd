extends Node


var mouse_input = Vector2.ZERO
var joy_input = Vector2.ZERO

var motion = Vector2.ZERO

var angle = 0
var last_ang = 0

var direction = Vector2.ZERO
var movement = Vector2.ZERO
var compass = Vector2.ZERO
var last_com = Vector2.ZERO

var click = 0

var use_joy = false

export var joy_zone := 0.1
export var mouse_smooth := 0.99

export var joy_smooth := 60


signal rotate(angle)
signal pressed()
signal released()
signal turn(compass)

func _process(delta):

	if use_joy:
		motion = (joy_input+motion)/2
	
	handle_angle()
	handle_direction()
	handle_compass()
	
	if last_ang != angle:
		emit_signal("rotate", angle)

func _input(event):
	
	handle_mouse(event)
	handle_joystick(event)
	handle_action(event)
	
	movement = direction*click

func handle_action(event):
	if event.is_action_pressed('ui_click'):
		click = 1
		emit_signal('pressed')
	elif event.is_action_released('ui_click'):
		click = 0
		emit_signal('released')

func handle_joystick(event):
	if event is InputEventJoypadMotion:
		use_joy = true

		if event.axis == 0 || event.axis == 2:
			joy_input.x = event.axis_value
		if event.axis == 1 || event.axis == 3:
			joy_input.y = event.axis_value
		if joy_input.x < joy_zone && joy_input.x > -joy_zone:
			joy_input.x = 0
		if joy_input.y < joy_zone && joy_input.y > -joy_zone:
			joy_input.y = 0			


func handle_mouse(event):
	if event is InputEventMouseMotion:
		use_joy = false

		mouse_input = event.relative
		motion = motion*mouse_smooth + mouse_input

func handle_angle():
	last_ang = angle
	angle = motion.angle()
	
func handle_direction():
	direction = motion.normalized()

func handle_compass():
	compass = direction.round()
	if compass.y != 0 && compass.x !=0:
		compass.y = 0
	if last_com != compass:
		emit_signal('turn', compass)
	last_com = compass

func is_moving():
	return click == 1
