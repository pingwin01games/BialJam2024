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
			get_tree().get_first_node_in_group("player").heal(5)
		queue_free()
