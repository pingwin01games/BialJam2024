extends Node2D

@onready var projectileScene : PackedScene = preload("res://scene/Guns/projectiles/bullet_template.tscn")
@onready var gunPos = $Gun_Point
@onready var ROF = $ROF
@onready var audio_shot = $Audio_Shot
@onready var gun_sprite = $Gun_Sprite


var canShoot = true

var reloading = false
var bonusReloading = false
var failBonusReloading = false

var maxAmmo = 30
var curAmmo = 30

var maxMag = 3
var curMag = 3

var distanceToGun = 0


var dmg = 100


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func reload():
	if curAmmo == 0 and curMag == 0:
		return 0
	if(curMag>0 and curAmmo<maxAmmo):
		curMag -= 1
		curAmmo = maxAmmo
		#animationplayer.play("reload")

func shoot():
	
	
	if canShoot == true and curAmmo > 0:
		audio_shot.play()
		curAmmo -= 1
		canShoot = false
		var projectile = projectileScene.instantiate()
		var projectiles = get_tree().get_first_node_in_group("projectiles")
	#var projectiles = get_tree().root
		var player = get_tree().get_first_node_in_group("player")
	
		projectile.position = player.position #- Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x)) + Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x))
		projectile.rotation = atan2(get_global_mouse_position().y-player.position.y,get_global_mouse_position().x-player.position.x)
		projectile.dmg = dmg
		projectiles.add_child(projectile)
		ROF.start()
	
func get_info(co):
	match co:
		"ammo":
			return curAmmo
		"mag":
			return curMag
		"MAX":
			return maxAmmo

func Flip(horizontal):
	gun_sprite.flip_v = horizontal

func _on_rof_timeout():
	canShoot = true # Replace with function body.
