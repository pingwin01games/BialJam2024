extends CharacterBody2D

@onready var minesROF = $Mines_ROF
@onready var mineScene :PackedScene = preload("res://scene/Enemies/Lung_Turret.tscn")

var curHP = 1000.0
var maxHP = 1000.0
var player

var mine
var canPlaceMine : bool = true
var mineLimit = 10
var curMineCount = 0

var mineSpawnPos = Vector2(250,250)

func _process(delta):
	if(canPlaceMine == true):
		if(curMineCount < mineLimit):
			PlaceMine()
			canPlaceMine = false
			curMineCount += 1
			minesROF.start()

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
		get_tree().get_first_node_in_group("player").heal(100)
		queue_free()

func _on_mines_rof_timeout():
	canPlaceMine = true


func _on_player_detector_body_entered(body):
	player = body
	player.BossName("The Lungs")
	player.BossHpUpdate(curHP,maxHP)
	body.BossInRange()


func _on_player_detector_body_exited(body):
	player = null
	body.BossOutRange()
