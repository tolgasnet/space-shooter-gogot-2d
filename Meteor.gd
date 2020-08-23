extends KinematicBody2D
class_name Meteor

var resetCounter = 4
var scoreCounter = 0
var hiscoreCounter = 0

func _ready():
	position.x = 500
	position.y = 0
	
func reset_meteor():
	var ship: KinematicBody2D = get_node("../Player")
	position.y = 0
	position.x = rand_range(10, 980)
		
func play_explosion(collider: KinematicBody2D) -> void:
	var explosion: AnimatedSprite = get_node("../Explosion")
	explosion.frame = 0
	explosion.play("explosion")
	explosion.position.x = collider.position.x;
	explosion.position.y = collider.position.y;
	
func _physics_process(delta: float) -> void:
	var speed = rand_range(200, 700)
	var velocity = Vector2()
	velocity.y += 1;
	var newVelocity = velocity.normalized() * speed * delta
	var collision = move_and_collide(newVelocity)
	
	if position.y > 600:
		reset_meteor()
		
	if collision is KinematicCollision2D:
		reset_meteor()
		var collider: KinematicBody2D = collision.collider
		play_explosion(collider)
		
		if collider is Player:
			collider.position.x = -5000
			collider.position.y = -5000
			resetCounter = 4
			$"../MainTimer".start()
			
		if collider is Bullet:
			collider.visible = false
			collider.position.y = -100
			scoreCounter += 1
			if (scoreCounter > hiscoreCounter):
				hiscoreCounter = scoreCounter
			$"../ScoreLabel".text = "Score: " + (scoreCounter as String)
			$"../HiscoreLabel".text = "Max: " + (hiscoreCounter as String)
		
func _on_Timer_timeout():
	resetCounter -= 1
	var label: RichTextLabel = $"../MainLabel"
	label.text = resetCounter as String
	
	if resetCounter == 0:
		label.text = "Go!"
		var ship: KinematicBody2D = get_node("../Player")
		ship.position.x = 500
		ship.position.y = 530
		
	if resetCounter == -1:
		$"../MainTimer".stop()
		resetCounter = 4
		scoreCounter = 0
		$"../ScoreLabel".text = "Score: 0"
		label.text = ""
		
