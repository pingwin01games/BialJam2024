extends CharacterBody2D

@onready var spawnerROF = $Spawner_ROF
var weaponsSpawnList=[]

var canPlaceMine : bool = true
var canSuck : bool = false

var SPEED = 100
var RUN_SPEED = 200

var player : Vector2 = Vector2.ZERO
var movementDirection : Vector2 = Vector2.ZERO

var weaponSpawnPos = Vector2(250,250)

func _ready():
	weaponsSpawnList.append(preload("res://scene/Enemies/rocket_launcher_spawn.tscn"))
	weaponsSpawnList.append(preload("res://scene/Enemies/rifle_spawn.tscn"))

func _process(delta):
	if(canPlaceMine == true):
		SpawnWeapon()
		canPlaceMine = false
		spawnerROF.start()
	
	player = get_tree().get_first_node_in_group("player").position
	movementDirection = player - position
	if movementDirection.length() > 256:
		velocity = movementDirection.normalized() * SPEED
	else:
		movementDirection = position - player
		velocity = movementDirection.normalized() * RUN_SPEED
	move_and_slide()
	

func SpawnWeapon():
	var rng = RandomNumberGenerator.new()
	var rnd = rng.randi_range(0,weaponsSpawnList.size()-1)
	print_debug(rnd)
	
	var newWeaponSpawn = weaponsSpawnList[rnd].instantiate()
	get_parent().add_child(newWeaponSpawn)
	
	var rndX = rng.randi_range(-weaponSpawnPos.x, weaponSpawnPos.x)
	var rndY = rng.randi_range(-weaponSpawnPos.y, weaponSpawnPos.y)
	var rndDist = rng.randi_range(100,150)
	
	var minePosition = Vector2(rndX,rndY)
	
	minePosition = minePosition.normalized()*rndDist
	
	minePosition.x += position.x
	minePosition.y += position.y
	
	newWeaponSpawn.position = minePosition

func _on_spawner_rof_timeout():
	canPlaceMine = true
