extends CharacterBody2D


const SPEED = 100
const RUN_SPEED = 200

var hp = 100

var pozycja_gracza : Vector2 = Vector2.ZERO
var kierunek_ruchu : Vector2 = Vector2.ZERO
var current_speed = 100

func _physics_process(delta):
	pozycja_gracza = get_tree().get_first_node_in_group("player").position
	
	kierunek_ruchu = pozycja_gracza - position
	if kierunek_ruchu.length() > 256:
		velocity = kierunek_ruchu.normalized() * SPEED
	else:
		kierunek_ruchu = position - pozycja_gracza
		velocity = kierunek_ruchu.normalized() * RUN_SPEED
	
	move_and_slide()

func hit(val):
	hp -= val
	if hp <= 0:
		queue_free()
