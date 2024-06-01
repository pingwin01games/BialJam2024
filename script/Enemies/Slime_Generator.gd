extends CharacterBody2D

@onready var minesROF = $Mines_ROF
@onready var mineScene :PackedScene = preload("res://scene/Enemies/slime.tscn")

var curHP = 1000.0
var maxHP = 1000.0
var player

var mine
var canPlaceMine : bool = true
var mineLimit = 5
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

	
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(-mineSpawnPos.x, mineSpawnPos.x)
	var rndY = rng.randi_range(-mineSpawnPos.y, mineSpawnPos.y)
	var rndDist = rng.randi_range(100,150)
	
	var minePosition = Vector2(rndX,rndY)
	
	minePosition = minePosition.normalized()*rndDist
	minePosition += position
	
	newMine.position= minePosition

func childHasBeenKilled():
	curMineCount -= 1

func hit(val):
	curHP -= val
	if(curHP<=0):
		queue_free()

func _on_mines_rof_timeout():
	canPlaceMine = true
