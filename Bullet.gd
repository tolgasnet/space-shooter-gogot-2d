extends KinematicBody2D
class_name Bullet

var bulletFired = false
var speed = -1200

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed('ui_select') and bulletFired == false:
		bulletFired = true
		visible = true
		var ship: KinematicBody2D = get_node("../Player")
		position.x = ship.position.x
		position.y = ship.position.y - 10
		
	if bulletFired:
		if position.y < 0:
			bulletFired = false
			position.y = -100
		var velocity = Vector2(0, speed)
		move_and_collide(velocity * delta)
