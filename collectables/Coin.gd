extends Area2D


onready var anim = $Anim

func _on_Coin_area_entered(area):
	get_tree().call_group('Coin', '_on_coin_pickup', self)


func _on_Area2D_area_entered(area):
	anim.play('glow')


func _on_Area2D_area_exited(area):
	anim.play('fade')
