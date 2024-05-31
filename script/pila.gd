extends CharacterBody2D

var SPEED = 50

var dmg = 10

func _physics_process(delta):
	
	velocity = Vector2.RIGHT.rotated(rotation) * SPEED
	
	move_and_slide()


func _on_area_of_damage_body_entered(body):
	if body.has_method("hit"):
		body.hit(dmg)
	else:
		print("i huj")
	queue_free()

func pass_dmg(val):
	dmg = val
