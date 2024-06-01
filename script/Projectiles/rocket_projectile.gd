extends "res://script/pila.gd"

@onready var animation_of_explosion = preload("res://scene/Guns/projectiles/animated_explosion.tscn")
@onready var area_of_explosion = $Area_Of_Explosion



func _ready():
	SPEED = 500



func _on_time_of_detenation_timeout():
	queue_free()



func _on_area_of_damage_body_entered(body):
	for targets in area_of_explosion.get_overlapping_bodies():
		if targets.has_method("hit"):
			targets.hit(dmg)
			print(targets)
		else:
			return 0
	var animation_of_explosion_inst = animation_of_explosion.instantiate()
	animation_of_explosion_inst.position = global_position
	var projectiles = get_tree().get_first_node_in_group("projectiles")
	projectiles.add_child(animation_of_explosion_inst)
	
	queue_free()
