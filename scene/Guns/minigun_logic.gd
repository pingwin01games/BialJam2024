extends "res://scene/Guns/gun_template.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	maxAmmo = 200
	curAmmo = 200
	maxMag = 2
	curMag = 2
	distanceToGun = 32
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")
