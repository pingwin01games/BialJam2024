extends "res://script/Enemies/enemy_weapon_spawn.gd"

func _ready():
	ammo = 4
	projectileScene = preload("res://scene/Projectiles/rocket_projectile.tscn")
	
