extends Node

var frozen = false setget set_frozen
var last_frozen = false
var target = null
var movement = Vector2.ZERO
var compass = Vector2.ZERO
var last_com = Vector2.ZERO
var run_dir = Vector2.ZERO

export var rand_max := 0.5
export var smooth := 0.8

signal turn(compass)
signal target(target)

onready var agent = get_parent()
onready var runtimer = get_node('../RunningTimer')
onready var hitbox = get_node('../LampHitbox')
onready var view = get_node('../View')
onready var intrest = get_node('../Intrest')

func _ready():
	reset_run_dir()


# warning-ignore:unused_argument
func _physics_process(delta):
	if target:
		if !frozen:
			movement = agent.position.direction_to(target.get_global_position())
		else:
			movement = target.get_global_position().direction_to(agent.position)
			movement += run_dir
		
		if !frozen && frozen != last_frozen:
			reset_run_dir()
	else:
		movement = movement*smooth
		
		
	if compass.y != 0 && compass.x !=0:
		compass.y = 0
	if last_com != compass:
		emit_signal('turn', compass)
	last_com = compass
		
func _on_View_area_entered(area):
	set_target(area.get_parent())


# warning-ignore:unused_argument
func _on_LampHitbox_area_entered(area):
	set_frozen(true)

func reset_run_dir():
	run_dir.x = rand_range(-rand_max,rand_max)
	run_dir.y = rand_range(-rand_max,rand_max)

# warning-ignore:unused_argument
func _on_LampHitbox_area_exited(area):
	runtimer.start(0.5)
	
func set_target(targ):
	if target == null:
		intrest.start(10)
		emit_signal("target", targ)
	target = targ


func _on_RuningTimer_timeout():
	if hitbox.get_overlapping_areas().size() > 0:
		runtimer.start(0.3)
	else:
		set_frozen(false)
		if rand_range(0,3) > 2:
			set_target(null)
	
func set_frozen(val):
	last_frozen = frozen
	frozen = val


func _on_Intrest_timeout():
	if view.get_overlapping_areas().size() > 0:
		intrest.start(10)
	else:
		set_target(null)
		
