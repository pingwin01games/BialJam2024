
extends CharacterBody2D

var projectileScene = preload("res://scene/Guns/projectiles/enemy_saw.tscn")

@onready var rof = $RoF


var SPEED = 100
var RUN_SPEED = 200

var hp = 100
var dmg = 10

var player : Vector2 = Vector2.ZERO
var kierunek_ruchu : Vector2 = Vector2.ZERO

var canShoot = false
var Shooting = false

func _process(delta):
	
	player = get_tree().get_first_node_in_group("player").position
	
	kierunek_ruchu = player - position
	if kierunek_ruchu.length() > 256:
		velocity = kierunek_ruchu.normalized() * SPEED
		
	else:
		kierunek_ruchu = position - player
		velocity = kierunek_ruchu.normalized() * RUN_SPEED
	
	if canShoot and not Shooting:
		var projectile = projectileScene.instantiate()
		var projectiles = get_tree().get_first_node_in_group("projectiles")
	#var projectiles = get_tree().root
		var player = get_tree().get_first_node_in_group("player")
		
		projectile.position = position #- Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x)) + Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x))
		projectile.rotation = atan2(player.position.y-position.y,player.position.x-position.x)
		projectile.dmg = dmg
		projectiles.add_child(projectile)
		Shooting = true
		rof.start()
		
	
	move_and_slide()
	
	

func hit(val):
	hp -= val
	if hp <= 0:
		queue_free()



func _on_area_of_attack_body_entered(body):
	canShoot = true


func _on_area_of_attack_body_exited(body):
	canShoot = false


func _on_rof_timeout():
	rof.stop()
	Shooting = false
