extends "res://script/Enemies/Faceshredder.gd"

var daddy

func _ready():
	hp = 30
	dmg = 10

func hit(val):
	hp -= val
	if hp <= 0:
		if daddy != null:
			daddy.childHasBeenKilled()
		queue_free()
