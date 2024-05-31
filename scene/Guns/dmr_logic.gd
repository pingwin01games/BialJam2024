extends "res://scene/Guns/gun_template.gd"


# Called when the node enters the scene tree for the first time.
func _ready():
	dmg = 50
	maxAmmo = 10
	curAmmo = 10
	maxMag = 3
	curMag = 3
	distanceToGun = 32
	projectileScene = preload("res://scene/Guns/projectiles/sniper_bullet.tscn")
