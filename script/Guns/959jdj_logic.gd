extends "res://script/Guns/gun_template.gd"

var sprite_weapon = load("res://Sprites/Hud/jdj959tohud.png")
# Called when the node enters the scene tree for the first time.
func _ready():
	dmg = 100
	maxAmmo = 5
	curAmmo = 5
	maxMag = 3
	curMag = 3
	projectileScene = preload("res://scene/Guns/projectiles/sniper_bullet.tscn")


