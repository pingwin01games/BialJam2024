extends CharacterBody2D

@onready var hand = $hand
@onready var pick_up = $CanvasLayer/UI/Can_Pick_Up
@onready var dodge = $Dodge_Time
@onready var dodge_cooldown = $Dodge_Cooldown


const SPEED = 300.0
const DASH_SPEED = 500.0
const MAXAMMO = 10

var canShoot = true
var currentAmmo 
var reloading = false
var bonusReloading = false
var failBonusReloading = false
var dashing = false
var canDash = true

var startBonusReload = 0.3
var starBonusReloadTime = 0.3

var direction : Vector2
var old_direction : Vector2

func _ready():
	pass


func _process(delta):
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	if Input.is_action_just_pressed("ui_accept") and canDash:
		dashing = true
		canDash = false
		dodge.start()
		dodge_cooldown.start()
		
	
	if dashing == false:
		old_direction = direction
	if dashing == true:
		old_direction = old_direction
	print(old_direction)
	
	if direction:
		if dashing:
			velocity.x = old_direction.x 
		
			velocity.y = old_direction.y 
		
			velocity = velocity.normalized()
		
			velocity *= DASH_SPEED
		else:
			velocity.x = direction.x 
		
			velocity.y = direction.y 
		
			velocity = velocity.normalized()
		
			velocity *= SPEED

	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.05)
		velocity.y = move_toward(velocity.y, 0, SPEED * 0.05)
	
	
	
	

	move_and_slide()
	
	hand.position = Vector2(1,0).rotated(atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x))
	hand.rotation = atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x)
	
	
		

func show_pick_up():
	pick_up.visible = true

func hide_pick_up():
	pick_up.visible = false


func _on_dodge_time_timeout():
	dashing = false
	dodge.stop()


func _on_dodge_cooldown_timeout():
	canDash = true
	dodge_cooldown.stop()
