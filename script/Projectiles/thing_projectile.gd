extends "res://script/pila.gd"


func _ready():
	SPEED = randi_range(150,450)



func _on_time_of_deletion_timeout():
	queue_free()

