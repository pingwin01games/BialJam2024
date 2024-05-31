extends "res://script/enemy_2.gd"

@onready var walking_cycle = $Walking_Cycle



func _ready():
	SPEED = 10
	RUN_SPEED = 20
	hp = 1000
	dmg = 10
	projectileScene = preload("res://scene/Guns/projectiles/thing_projectile.tscn")
	rof.wait_time = 0.5

func _process(delta):
	
	walking_cycle.play("default")
	
	player = get_tree().get_first_node_in_group("player").position
	
	kierunek_ruchu = player - position
	if kierunek_ruchu.length() > 256:
		velocity = kierunek_ruchu.normalized() * SPEED
		
	else:
		kierunek_ruchu = position - player
		velocity = kierunek_ruchu.normalized() * RUN_SPEED
	
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
	
