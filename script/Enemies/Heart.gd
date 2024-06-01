extends CharacterBody2D

@onready var minesROF = $Mines_ROF
@onready var mineScene :PackedScene = preload("res://scene/Enemies/Lung_Turret.tscn")
@onready var projectileScene = preload("res://scene/Guns/projectiles/thing_projectile.tscn")
@onready var rof = $ROF
@onready var credits = preload("res://scene/Maps/credits.tscn")


var curHP = 3000.0
var maxHP = 3000.0
var player

var mine
var canPlaceMine : bool = true
var mineLimit = 20
var curMineCount = 0
var dmg = 10

var canShoot = false
var Shooting = false

var mineSpawnPos = Vector2(250,250)

func _process(delta):
	if(canPlaceMine == true):
		if(curMineCount < mineLimit):
			PlaceMine()
			canPlaceMine = false
			curMineCount += 1
			minesROF.start()
	
	if canShoot and not Shooting:
		var projectile = projectileScene.instantiate()
		var projectiles = get_tree().get_first_node_in_group("projectiles")
	#var projectiles = get_tree().root
		var player = get_tree().get_first_node_in_group("player")
		
		projectile.position = position + Vector2(300,0).rotated(atan2(player.position.y-position.y,player.position.x-position.x)+randf_range(-180,180)) #- Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x)) + Vector2(distanceToGun,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x))
		projectile.rotation = atan2(player.position.y-position.y,player.position.x-position.x)
		projectile.dmg = dmg
		projectiles.add_child(projectile)
		Shooting = true
		rof.start()
	
	if curHP < 750:
		rof.wait_time = 0.25

func PlaceMine():
	var newMine = mineScene.instantiate()
	get_parent().add_child(newMine)
	newMine.daddy = self
	print(newMine.daddy)
	
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(-mineSpawnPos.x, mineSpawnPos.x)
	var rndY = rng.randi_range(-mineSpawnPos.y, mineSpawnPos.y)
	var rndDist = rng.randi_range(300,450)
	
	var minePosition = Vector2(rndX,rndY)
	
	minePosition = minePosition.normalized()*rndDist
	minePosition += position
	
	newMine.position= minePosition

func childHasBeenKilled():
	curMineCount -= 1

func hit(val):
	curHP -= val
	player.BossHpUpdate(curHP,maxHP)
	if(curHP<=0):
		player.BossOutRange()
		queue_free()
		get_tree().change_scene_to_packed(credits)

func _on_mines_rof_timeout():
	canPlaceMine = true


func _on_player_detector_body_entered(body):
	player = body
	player.BossName("Anomaly-2137 \"H3@rt 0f 30r1d\"")
	player.BossHpUpdate(curHP,maxHP)
	body.BossInRange()


func _on_player_detector_body_exited(body):
	player = null
	body.BossOutRange()

func _on_area_of_attack_body_entered(body):
	canShoot = true


func _on_area_of_attack_body_exited(body):
	canShoot = false

func _on_rof_timeout():
	rof.stop()
	Shooting = false

