extends CharacterBody2D

@onready var minesROF = $Mines_ROF
@onready var suckROF = $Sucking_ROF
@onready var mineScene :PackedScene = preload("res://scene/blok.tscn")

var mine
var canPlaceMine : bool = true
var canSuck : bool = false
var mineLimit = 10
var curMineCount = 0

var curSuckingTime = 0.0
var suckingMaxTime = 20.0

var mineSpawnPos = Vector2(250,250)

func _process(delta):
	if(canPlaceMine == true):
		if(curMineCount < mineLimit):
			PlaceMine()
			canPlaceMine = false
			curMineCount += 1
			minesROF.start()
			
	if (canSuck == true):
		curSuckingTime += delta
		if(curSuckingTime < suckingMaxTime):
			suck()
		else:
			canSuck = false
			curSuckingTime = 0.0
			suckROF.start()
		

func PlaceMine():
	var newMine = mineScene.instantiate()
	get_parent().add_child(newMine)
	

	
	var rng = RandomNumberGenerator.new()
	var rndX = rng.randi_range(-mineSpawnPos.x, mineSpawnPos.x)
	var rndY = rng.randi_range(-mineSpawnPos.y, mineSpawnPos.y)
	var rndDist = rng.randi_range(250,350)
	
	var minePosition = Vector2(rndX,rndY)
	
	minePosition = minePosition.normalized()*rndDist
	
	newMine.position= minePosition


func _on_mines_rof_timeout():
	canPlaceMine = true


func _on_sucking_rof_timeout():
	canSuck = true

func suck():
	print_debug("SUCKIING")
	var player = get_tree().get_first_node_in_group("player")
	
	var playerVelocity = Vector2((move_toward(player.position.x, position.x, 300* 0.002)),move_toward(player.position.y, position.y, 300 * 0.002))
	
	playerVelocity.normalized()
	
	player.velocity -= playerVelocity*0.1
	
