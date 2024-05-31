extends "res://scene/Guns/gun_template.gd"

var sprite_weapon = load("res://Sprites/Hud/sparkwpnhud.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	dmg = 24
	maxAmmo = 6
	curAmmo = 6
	maxMag = 4
	curMag = 4
	distanceToGun = 32
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")

func shoot():
	if canShoot == true and curAmmo > 0:
		audio_shot.play()
		curAmmo -= 1
		canShoot = false
		for i in 6:
			var projectile = projectileScene.instantiate()
			var projectiles = get_tree().get_first_node_in_group("projectiles")
	#var projectiles = get_tree().root
			var player = get_tree().get_first_node_in_group("player")
			projectile.dmg = dmg
			projectile.position = player.position #- Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x)) + Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x))
			projectile.rotation = randf_range(-0.2, 0.2) + atan2(get_global_mouse_position().y-player.position.y,get_global_mouse_position().x-player.position.x)
	
			projectiles.add_child(projectile)
		ROF.start()
