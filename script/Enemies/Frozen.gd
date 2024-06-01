extends "res://script/Enemies/enemy_2.gd"


func _ready():
	dmg = 20
	projectileScene= preload("res://scene/Guns/projectiles/frozen_projectile.tscn")
