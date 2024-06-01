extends "res://script/Enemies/EnemyMinionsSpawn/enemy_weapon_spawn.gd"

func _ready():
	ammo = 4
	projectileScene = preload("res://scene/Guns/Projectiles/rocket_projectile.tscn")
	
