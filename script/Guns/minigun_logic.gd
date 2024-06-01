extends "res://script/Guns/gun_template.gd"

var sprite_weapon = load("res://Sprites/Hud/minigunhud.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	dmg = 15
	maxAmmo = 200
	curAmmo = 200
	maxMag = 2
	curMag = 2
	distanceToGun = 32
	projectileScene = preload("res://scene/Guns/projectiles/bullet.tscn")
