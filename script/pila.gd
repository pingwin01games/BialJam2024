extends CharacterBody2D

var SPEED = 50


func _physics_process(delta):
	
	velocity = Vector2.RIGHT.rotated(rotation) * SPEED
	move_and_slide()


func _on_area_of_damage_body_entered(body):
	body.queue_free()
	queue_free()
