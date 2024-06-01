extends CharacterBody2D


const SPEED = 150

var hp = 100
var dmg = 40
var exploding = false

var playerPos : Vector2 = Vector2.ZERO
var movementDirection : Vector2 = Vector2.ZERO
@onready var exploding_timer = $"Exploding timer"
@onready var explosion_sprite = $ExplosionSprite
@onready var sprite_2d = $Sprite2D
@onready var animated_sprite_2d = $AnimatedSprite2D

@onready var dmg_area = $Dmg_Area


func _process(delta):
	if exploding == true:
		return
	var player = get_tree().get_first_node_in_group("player").position
	
	movementDirection = player - position
	if movementDirection.length() < 75:
		exploding = true
		StartExploding()

func _physics_process(delta):
	if exploding == true:
		return
	playerPos = get_tree().get_first_node_in_group("player").position
	
	movementDirection = playerPos - position
	velocity = movementDirection.normalized() * SPEED
	
	move_and_slide()

func hit(val):
	hp -= val
	if hp <= 0:
		queue_free()
		

func StartExploding():
	sprite_2d.visible = false
	animated_sprite_2d.visible = true
	animated_sprite_2d.play("default")

func explode():
	sprite_2d.visible = false
	explosion_sprite.visible = true
	animated_sprite_2d.visible = false
	explosion_sprite.play("default")
	for body in dmg_area.get_overlapping_bodies():
		if body.has_method("hit"):
			body.hit(dmg)



func _on_explosion_sprite_animation_finished():
	queue_free()


func _on_animated_sprite_2d_animation_finished():
	explode()
