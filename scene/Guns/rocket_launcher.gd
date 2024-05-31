extends "res://scene/Guns/gun_template.gd"


func _ready():
	maxAmmo = 4
	curAmmo = 4
	
	maxMag = 4
	curMag = 4
	
	projectileScene = preload("res://scene/Projectiles/rocket_projectile.tscn")
