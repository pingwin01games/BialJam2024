extends "res://script/Enemies/EnemyMinionsSpawn/enemy_weapon_spawn.gd"

func _ready():
	ammo = 30
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")
