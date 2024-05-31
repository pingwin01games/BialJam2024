extends "res://scene/Guns/gun_template.gd"

var sprite_weapon = load("res://Sprites/Hud/uzitohud.png")

func _ready():
	dmg = 10
	maxAmmo = 50
	curAmmo = 50
	maxMag = 3
	curMag = 3
	distanceToGun = 32
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")

func shoot():
	if canShoot == true and curAmmo > 0:
		audio_shot.play()
		curAmmo -= 2
		canShoot = false
		for i in 2:
			var projectile = projectileScene.instantiate()
			var projectiles = get_tree().get_first_node_in_group("projectiles")
	#var projectiles = get_tree().root
			var player = get_tree().get_first_node_in_group("player")
			projectile.dmg = dmg
			projectile.position = player.position #- Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x)) + Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x))
			projectile.rotation = randf_range(-0.5, 0.5) + atan2(get_global_mouse_position().y-player.position.y,get_global_mouse_position().x-player.position.x)
	
			projectiles.add_child(projectile)
		ROF.start()
