extends "res://script/Enemies/enemy_weapon_spawn.gd"

func _ready():
	ammo = 30
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")
