extends "res://script/pila.gd"


func _ready():
	SPEED = 500



func _on_time_of_detenation_timeout():
	queue_free()
