extends "res://script/Guns/gun_template.gd"

var sprite_weapon = load("res://Sprites/Hud/m202tohud-removebg-preview.png")

func _ready():
	dmg = 200
	maxAmmo = 4
	curAmmo = 4
	maxMag = 4
	curMag = 4
	distanceToGun = 32
	projectileScene = preload("res://scene/Guns/projectiles/rocket_projectile.tscn")

func get_info(co):
	match co:
		"ammo":
			return curAmmo
		"mag":
			return curMag
		"MAX":
			return maxAmmo
