extends "res://scene/Guns/gun_template.gd"



func _ready():
	maxAmmo = 30
	curAmmo = 30
	maxMag = 6
	curMag = 4
	distanceToGun = 32
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")


