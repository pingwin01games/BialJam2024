extends "res://script/Enemies/enemy_2.gd"

@onready var walking_cycle = $Walking_Cycle

var maxHP = 1000.0

var playerObject

func _ready():
	SPEED = 10
	RUN_SPEED = 20
	hp = 1000.0
	dmg = 10
	projectileScene = preload("res://scene/Guns/projectiles/thing_projectile.tscn")
	rof.wait_time = 0.5

func _process(delta):
	
	walking_cycle.play("default")
	
	player = get_tree().get_first_node_in_group("player").position
	
	movementDirection = player - position
	if movementDirection.length() > 256:
		velocity = movementDirection.normalized() * SPEED
		
	else:
		movementDirection = position - player
		velocity = movementDirection.normalized() * RUN_SPEED
	
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
	
	if hp < 500:
		rof.wait_time = 0.25
	
	move_and_slide()
	
func get_hp():
	return[hp,maxHP]

func hit(val):
	hp -= val
	playerObject.BossHpUpdate(hp,maxHP)
	playerObject.BossName("S?#ke38?b")
	if(hp<=0):
		playerObject.BossOutRange()
		get_tree().get_first_node_in_group("player").heal(100)
		queue_free()

func _on_player_detector_body_entered(body):
	playerObject = body
	playerObject.BossHpUpdate(hp,maxHP)
	playerObject.BossName("S?#ke38?b")
	body.BossInRange()


func _on_player_detector_body_exited(body):
	playerObject = null
	body.BossOutRange()
