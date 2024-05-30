extends CharacterBody2D



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
		velocity.x = direction.x 
		
		velocity.y = direction.y 
		
		velocity = velocity.normalized()
		
		velocity *=SPEED
		
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.05)
		velocity.y = move_toward(velocity.y, 0, SPEED * 0.05)

	move_and_slide()
	
	


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
	
