extends Node2D

@onready var projectileScene : PackedScene = preload("res://scene/bullet_template.tscn")
@onready var gunPos = $Gun_Point
@onready var ROF = $ROF


var canShoot = true

var reloading = false
var bonusReloading = false
var failBonusReloading = false

var maxAmmo = 30
var curAmmo = 30

var maxMag = 3
var curMag = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func reload():
	if(curMag>0):
		curMag -= 1
		curAmmo = maxAmmo
		#animationplayer.play("reload")

func shoot():
	var projectile = projectileScene.instantiate()
	var projectiles = get_tree().get_first_node_in_group("projectiles")
	#var projectiles = get_tree().root
	
	projectile.position = gunPos.global_position + Vector2(300,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x))
	projectile.rotation = atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x)
	
	projectiles.add_child(projectile)
	
	ROF.start()
	


func _on_rof_timeout():
	canShoot = true # Replace with function body.
