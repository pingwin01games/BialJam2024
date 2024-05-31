extends CharacterBody2D

@onready var hand = $hand
@onready var pick_up = $CanvasLayer/UI/Can_Pick_Up
@onready var dodge = $Dodge_Time
@onready var dodge_cooldown = $Dodge_Cooldown
@onready var walking_cycle = $Walking_Cycle


const SPEED = 300.0
const DASH_SPEED = 500.0
const MAXAMMO = 10

var canShoot = true
var currentAmmo = 0
var currentMag = 0
var reloading = false
var bonusReloading = false
var failBonusReloading = false
var dashing = false
var canDash = true

var maxHP = 100
var curHP = 100

var startBonusReload = 0.3
var starBonusReloadTime = 0.3

var direction : Vector2
var old_direction : Vector2
var atanek2

func _ready():
	$CanvasLayer/UI/Weapon_Texture.texture = hand.get_child(0).sprite_weapon


func _process(delta):

	
	$CanvasLayer/UI/Ammo_Count.text = str(currentAmmo)+' / '+str(currentMag)
	$CanvasLayer/UI/HP_Display.text = str(curHP)
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	
	atanek2 = atan2(get_global_mouse_position().y-position.y,get_global_mouse_position().x-position.x)
	
	if Input.is_action_just_pressed("ui_accept") and canDash:
		dashing = true
		canDash = false
		dodge.start()
		dodge_cooldown.start()
		
	
	if dashing == false:
		old_direction = direction
	if dashing == true:
		old_direction = old_direction
	
	
	if direction:
		walking_cycle.play("default")
		if dashing:
			velocity = old_direction.normalized() * DASH_SPEED
		else:
			velocity = direction.normalized() * SPEED

	else:
		walking_cycle.stop()
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.05)
		velocity.y = move_toward(velocity.y, 0, SPEED * 0.05)
	

	move_and_slide()
	
	hand.position = Vector2(1,0).rotated(atanek2)
	hand.rotation = atanek2
	
	if rad_to_deg(atanek2) > -90 and rad_to_deg(atanek2) < 90:
		walking_cycle.flip_h = false
	else:
		walking_cycle.flip_h = true


func show_pick_up():
	pick_up.visible = true

func hide_pick_up():
	pick_up.visible = false

func change_weapon(weapon):
	var weaponOut = hand.get_child(0)
	$CanvasLayer/UI/Weapon_Texture.texture = weapon.sprite_weapon
	hand.add_child(weapon)
	hand.remove_child(weaponOut)
	return weaponOut

func _on_dodge_time_timeout():
	dashing = false
	dodge.stop()


func _on_dodge_cooldown_timeout():
	canDash = true
	dodge_cooldown.stop()

func hit(val):
	curHP -= val
	print_debug(curHP)
	if curHP <= 0:
		get_tree().reload_current_scene()
