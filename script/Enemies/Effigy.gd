extends CharacterBody2D


const SPEED = 150

var hp = 100
var dmg = 40

var playerPos : Vector2 = Vector2.ZERO
var movementDirection : Vector2 = Vector2.ZERO

@onready var dmg_area = $Dmg_Area

var target

func _process(delta):
	if target!=null:
		explode()

func _physics_process(delta):
	playerPos = get_tree().get_first_node_in_group("player").position
	
	movementDirection = playerPos - position
	velocity = movementDirection.normalized() * SPEED
	
	move_and_slide()

func hit(val):
	hp -= val
	if hp <= 0:
		queue_free()
		

func explode():
	for body in dmg_area.get_overlapping_bodies():
		if body.has_method("hit"):
			body.hit(dmg)
	queue_free()

func _on_attack_area_body_entered(body):
	target = body


func _on_attack_area_body_exited(body):
	target = null
