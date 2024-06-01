extends "res://script/Enemies/EnemyMinionsSpawn/enemy_weapon_spawn.gd"

func _ready():
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")
	ammo = 30

func shoot():
	if canShoot == true and ammo > 0:
		ammo -= 2
		canShoot = false
		for i in 2:
			var projectile = projectileScene.instantiate()
			var projectiles = get_tree().get_first_node_in_group("projectiles")
	#var projectiles = get_tree().root
			var player = get_tree().get_first_node_in_group("player")
			projectile.dmg = dmg
			projectile.get_child(2).set_collision_mask(1)
			projectile.get_child(2).set_collision_mask_value(3,0)
			projectile.position= global_position
			projectile.rotation = randf_range(-0.5, 0.5) +atan2(player.position.y-position.y,player.position.x-position.x)
			projectile.dmg = dmg
	
			projectiles.add_child(projectile)
		rof.start()
	else:
		queue_free()
