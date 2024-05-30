extends CharacterBody2D

@onready var rof = $RoF
@onready var pocisk = preload("res://scene/pila.tscn")
@onready var reload = $Reload_Time
@onready var ammo_count = $CanvasLayer/UI/Ammo_Count
@onready var reload_bar = $CanvasLayer/UI/Reload_bar
@onready var bonus_reload = $Bonus_Reload


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
	currentAmmo = MAXAMMO
	reload_bar.max_value = reload.wait_time

func _process(delta):
	
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	if direction:
		velocity.x = direction.x * SPEED 
		
		velocity.y = direction.y * SPEED 
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.05)
		velocity.y = move_toward(velocity.y, 0, SPEED * 0.05)

	move_and_slide()
	
	if Input.is_action_just_pressed("shoot") and canShoot and currentAmmo>=0 and reloading == false:
	
		rof.start()
		currentAmmo -= 1
		var bul = pocisk.instantiate()
		var atanek2 = atan2(get_global_mouse_position().y-position.y, get_global_mouse_position().x-position.x)
		bul.position = position + Vector2(300,0).rotated(atanek2)
		bul.rotation = atanek2
		get_tree().root.add_child(bul)
		
		canShoot = false
		
	if Input.is_action_just_pressed("reload") and currentAmmo < MAXAMMO and reloading == false:
		reload.start()
		currentAmmo = MAXAMMO
		reloading = true
		reload_bar.visible = true
		startBonusReload = 1 - randf_range(0.2,0.4)
		print(startBonusReload)
		starBonusReloadTime = randf_range(0.2,0.4)
		bonus_reload.wait_time = starBonusReloadTime
		print("poczatek reload")
	
	reload_bar.value = reload.time_left
	
	if reload.time_left < startBonusReload and reloading == true and bonusReloading == false and failBonusReloading == false :
			bonus_reload.start()
			bonusReloading = true
			reload_bar.modulate = Color(0,1,0)
	
	if Input.is_action_just_pressed("reload") and reloading == true and failBonusReloading == false:
		if reload_bar.modulate == Color(0,1,0):
			reload.stop()
			bonus_reload.stop()
			reloading = false
			reload_bar.visible = false
			bonusReloading = false
			print("szybszy koniec reload")
			reload_bar.modulate = Color(1,1,1)
		elif reload_bar.modulate == Color(1,1,1) and reload.time_left != 1:
			reload_bar.modulate = Color(1,0,0)
			failBonusReloading = true
			
			
func _on_ro_f_timeout():
	canShoot = true
	rof.stop()



func _on_reload_time_timeout():
	reloading = false
	reload_bar.visible = false
	reload.stop()
	bonusReloading = false
	failBonusReloading = false
	print("koniec reload")
	reload_bar.modulate = Color(1,1,1)
	

func _on_bonus_reload_timeout():
	reload_bar.modulate = Color(1,1,1)
	bonus_reload.stop()
	print("brak bonusu")
	print(reload.time_left)
	
