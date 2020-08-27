extends KinematicBody2D
class_name Player

var speed = 550
const startingX = 500
const startingY = 530
const rightBorder = 1025
const leftBorder = 0
const topBorder = 0
const bottomBorder = 600

func _ready():
	position.x = startingX;
	position.y = startingY;
	
func get_input():		
	var velocity = Vector2()
	if Input.is_action_pressed('ui_right') and position.x < rightBorder:
		velocity.x += 1
	if Input.is_action_pressed('ui_left') and position.x > leftBorder:
		velocity.x -= 1
	if Input.is_action_pressed('ui_down') and position.y < bottomBorder:
		velocity.y += 1
	if Input.is_action_pressed('ui_up') and position.y > topBorder:
		velocity.y -= 1
	return velocity.normalized() * speed
	
func _physics_process(delta: float) -> void:
	var newVelocity = get_input()
	move_and_collide(newVelocity * delta)
