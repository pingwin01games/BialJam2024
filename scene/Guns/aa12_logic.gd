extends "res://scene/Guns/gun_template.gd"


func _ready():
	dmg = 12
	maxAmmo = 8
	curAmmo = 8
	maxMag = 3
	curMag = 3
	distanceToGun = 32
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")

func shoot():
	if canShoot == true and curAmmo > 0:
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
