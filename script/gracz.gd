extends CharacterBody2D

@onready var rof = $RoF
@onready var pocisk = preload("res://scene/pila.tscn")

const SPEED = 300.0

var canShoot = true

var direction : Vector2



func _process(delta):
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction.x * SPEED 
		
		velocity.y = direction.y * SPEED 
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.05)
		velocity.y = move_toward(velocity.y, 0, SPEED * 0.05)

	
	
	if Input.is_action_just_pressed("shoot") and canShoot:
	
		rof.start()
		var bul = pocisk.instantiate()
		var atanek2 = atan2(get_global_mouse_position().y-position.y, get_global_mouse_position().x-position.x)
		bul.position = position + Vector2(300,0).rotated(atanek2)
		bul.rotation = atanek2
		get_tree().root.add_child(bul)
		
		canShoot = false
		
	
	move_and_slide()


func _on_ro_f_timeout():
	canshoot = true
	rof.stop()
	print("bam")
