extends CharacterBody2D


const SPEED = 200

var hp = 100
var dmg = 5

var playerPos : Vector2 = Vector2.ZERO
var movementDirection : Vector2 = Vector2.ZERO

@onready var rof = $ROF
var target
var canHit = true

func _process(delta):
	if target!=null and canHit == true:
		if target.has_method("hit"):
			target.hit(dmg)
			canHit = false
			rof.start()

func _physics_process(delta):
	playerPos = get_tree().get_first_node_in_group("player").position
	
	movementDirection = playerPos - position
	velocity = movementDirection.normalized() * SPEED
	
	move_and_slide()

func hit(val):
	hp -= val
	if hp <= 0:
		queue_free()
		

func _on_attack_area_body_entered(body):
	target = body


func _on_attack_area_body_exited(body):
	target = null


func _on_rof_timeout():
	canHit = true
