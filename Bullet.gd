extends KinematicBody2D
class_name Bullet

var bulletFired = false
var bulletFxPlayed = false
var speed = -1200
const yOffset = 10
const topBorder = 0
const yOutOfScreen = -100
onready var bulletFx: AudioStreamPlayer2D = get_node("../BulletFx")
onready var ship: KinematicBody2D = get_node("../Player")

func fire_bullet():
	bulletFired = true
	visible = true
	position.x = ship.position.x
	position.y = ship.position.y - yOffset

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_select') and bulletFired == false:
		fire_bullet()
		
	if bulletFired:
		var velocity = Vector2(0, speed)
		move_and_collide(velocity * delta)
		
		if bulletFxPlayed == false:
			bulletFxPlayed = true
			bulletFx.play()
			
		if position.y < topBorder:
			bulletFired = false
			bulletFxPlayed = false
			position.y = yOutOfScreen
