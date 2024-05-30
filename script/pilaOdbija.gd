extends RigidBody2D

const FORCE = 500

# Called when the node enters the scene tree for the first time.
func _ready():
	apply_central_force(Vector2(1,0).rotated(rotation) * FORCE)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_of_damage_body_entered(body):
	body.queue_free()
	queue_free()
