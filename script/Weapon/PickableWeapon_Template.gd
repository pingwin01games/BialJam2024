extends Node2D

var player
@onready var gun = $Gun_Template

func _on_pickup_area_2d_body_entered(body):
	if body.has_method("show_pick_up"):
		body.show_pick_up()
		player = body


func _on_pickup_area_2d_body_exited(body):
	if body.has_method("hide_pick_up"):
		body.hide_pick_up()
		player = null

func _process(delta):
	if Input.is_action_just_pressed("switch"):
		if player != null:
			remove_child(gun)
			var weaponOut = player.change_weapon(gun)
			add_child(weaponOut)
			gun = weaponOut
			
