extends CharacterBody2D

var player
@onready var shooting_pos = $Shooting_Pos
@onready var rof = $ROF
@onready var projectileScene = preload("res://scene/Guns/projectiles/bullet_template.tscn")

var dmg = 5
var canShoot = true
var playerInRange = false

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _process(delta):
	shooting_pos.position = to_local(player.position).normalized() * 50
	if canShoot and playerInRange:
		shoot()
		canShoot = false
		rof.start()

func shoot():
	var projectile = projectileScene.instantiate()
	get_tree().get_first_node_in_group("projectiles").add_child(projectile)
	projectile.position= shooting_pos.global_position
	projectile.rotation = atan2(player.position.y-position.y,player.position.x-position.x)
	projectile.dmg = dmg

func _on_rof_timeout():
	canShoot = true


func _on_player_detector_body_exited(body):
	playerInRange = false


func _on_player_detector_body_entered(body):
	playerInRange = true
