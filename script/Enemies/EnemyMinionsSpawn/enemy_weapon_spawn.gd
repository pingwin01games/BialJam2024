extends CharacterBody2D

var player
@onready var rof = $ROF
@onready var projectileScene

var dmg = 5
var canShoot = true
var ammo = 4

func _ready():
	player = get_tree().get_first_node_in_group("player")

func _process(delta):
	player = get_tree().get_first_node_in_group("player")
	rotation = atan2(player.position.y-position.y,player.position.x-position.x)
	if canShoot:
		shoot()
		canShoot = false
		rof.start()
		ammo -= 1
	if ammo == 0:
		queue_free()

func shoot():
	var projectile = projectileScene.instantiate()
	get_tree().get_first_node_in_group("projectiles").add_child(projectile)
	projectile.get_child(2).set_collision_mask(1)
	projectile.position= global_position
	projectile.rotation = atan2(player.position.y-position.y,player.position.x-position.x)
	projectile.dmg = dmg

func _on_rof_timeout():
	canShoot = true
