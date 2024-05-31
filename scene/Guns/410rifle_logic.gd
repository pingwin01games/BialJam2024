extends "res://scene/Guns/gun_template.gd"

var sprite_weapon = load("res://Sprites/Hud/hud410rifle.png")

func _ready():
	dmg = 30
	maxAmmo = 30
	curAmmo = 30
	maxMag = 6
	curMag = 4
	distanceToGun = 32
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")


