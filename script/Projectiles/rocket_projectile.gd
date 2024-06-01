extends "res://script/pila.gd"

@onready var animation_of_explosion = preload("res://scene/Guns/projectiles/animated_explosion.tscn")


func _ready():
	SPEED = 500



func _on_time_of_detenation_timeout():
	queue_free()



func _on_area_of_damage_body_entered(body):
	if body.has_method("hit"):
		body.hit(dmg)
	else:
		return 0
	var animation_of_explosion_inst = animation_of_explosion.instantiate()
	animation_of_explosion_inst.position = position
	var projectiles = get_tree().get_first_node_in_group("projectiles")
	projectiles.add_child(animation_of_explosion_inst)
	
	queue_free()
