extends Node2D

@onready var reload = $Reload_Time
@onready var bonus_reload = $Bonus_Reload
@onready var ammo_count = $CanvasLayer/UI/Ammo_Count
@onready var reload_bar = $CanvasLayer/UI/Reload_bar
@onready var rof = $RoF

var currentAmmo = 0
var reloading = false
var startBonusReload = 0.3
var starBonusReloadTime = 0.3
var bonusReloading = false
var failBonusReloading = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_child(0).has_method("get_info"):
		currentAmmo = get_child(0).get_info("ammo")
	
	
	if Input.is_action_just_pressed("shoot"):
		if get_child(0).has_method("shoot"):
			get_child(0).shoot()
	
		
	if Input.is_action_just_pressed("reload") and reloading == false:
		reload.start()
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

