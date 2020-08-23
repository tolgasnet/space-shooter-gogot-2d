extends KinematicBody2D
class_name Bullet

var bulletFired = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed('ui_select'):
		bulletFired = true
		visible = true
		var ship: KinematicBody2D = get_node("../Player")
		position.x = ship.position.x
		position.y = ship.position.y - 10
		
	if bulletFired:
		if position.y < 0:
			bulletFired = false
			visible = false
		var velocity = Vector2(0, -900)
		move_and_collide(velocity * delta)
