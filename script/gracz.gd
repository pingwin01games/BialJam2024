extends CharacterBody2D

@onready var hand = $hand


const SPEED = 300.0
const MAXAMMO = 10

var canShoot = true
var currentAmmo 
var reloading = false
var bonusReloading = false
var failBonusReloading = false

var startBonusReload = 0.3
var starBonusReloadTime = 0.3

var direction : Vector2

func _ready():
	pass


func _process(delta):
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction.x 
		
		velocity.y = direction.y 
		
		velocity = velocity.normalized()
		
		velocity *=SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.05)
		velocity.y = move_toward(velocity.y, 0, SPEED * 0.05)

	move_and_slide()
	
	hand.position = Vector2(1,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x))
	hand.rotation = atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x)

