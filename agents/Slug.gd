extends KinematicBody2D



export var speed := 5000
onready var anim = $Anim
onready var eyeanim = $EyeAnim
onready var ai = $Ai


func _on_Ai_turn(compass):
	anim.play(get_anim_name())

func _on_Ai_target(target):
	eyeanim.play("glow")
	eyeanim.queue("eye_fade")


func _physics_process(delta):
	move_and_slide(ai.movement * speed * delta)

func _on_LampHitbox_area_entered(area):
	eyeanim.play("eye_shine")


func _on_LampHitbox_area_exited(area):
	eyeanim.play("eye_fade")
	
func get_anim_name()->String:
	if ai.compass.x == -1:
		return 'left'
	if ai.compass.x == 1:
		return 'right'
	if ai.compass.y == -1:
		return 'up'
	if ai.compass.y == 1:
		return 'down'
	return 'down'


