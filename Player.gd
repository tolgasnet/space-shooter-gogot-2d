extends KinematicBody2D
class_name Player

var speed = 500

func _ready():
	position.x = 500;
	position.y = 530;
	
func get_input():		
	var velocity = Vector2()
	if Input.is_action_pressed('ui_right') and position.x < 1025:
		velocity.x += 1
	if Input.is_action_pressed('ui_left') and position.x > 0:
		velocity.x -= 1
	if Input.is_action_pressed('ui_down') and position.y < 600:
		velocity.y += 1
	if Input.is_action_pressed('ui_up') and position.y > 0:
		velocity.y -= 1
	return velocity.normalized() * speed
	
func _physics_process(delta: float) -> void:
	var newVelocity = get_input()
	move_and_collide(newVelocity * delta)
