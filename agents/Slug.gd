extends KinematicBody2D

onready var anim = $Anim


func _on_LampHitbox_area_entered(area):
	anim.play("eye_shine")


func _on_LampHitbox_area_exited(area):
	anim.play("eye_fade")
