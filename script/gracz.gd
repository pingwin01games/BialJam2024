extends CharacterBody2D

@onready var bron = $bron


const SPEED = 300.0


var direction : Vector2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction.x * SPEED 
		
		velocity.y = direction.y * SPEED 
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.05)
		velocity.y = move_toward(velocity.y, 0, SPEED * 0.05)

	bron.target_position = get_global_mouse_position() - position
	
	if Input.is_action_just_pressed("shoot"):
		if bron.is_colliding():
			var cell = bron.get_collider()
			cell.queue_free()
			
	
	move_and_slide()
