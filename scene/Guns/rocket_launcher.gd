extends "res://scene/Guns/gun_template.gd"


func _ready():
	dmg = 200
	maxAmmo = 1
	curAmmo = 1
	maxMag = 5
	curMag = 5
	distanceToGun = 32
	projectileScene = preload("res://scene/Projectiles/rocket_projectile.tscn")

func get_info(co):
	match co:
		"ammo":
			return curAmmo
		"mag":
			return curMag
		"MAX":
			return maxAmmo
