extends "res://script/pila.gd"

func _ready():
	SPEED = 1


func _on_time_of_deletion_timeout():
	queue_free()
