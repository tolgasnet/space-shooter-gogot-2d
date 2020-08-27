extends KinematicBody2D
class_name Meteor

const shipStartingX = 500
const shipStartingY = 530
var resetCounter = 4
var scoreCounter = 0
var hiscoreCounter = 0
const bottomBorder = 600
const outOfScreenPoint = -5000
var meteorSpeed: int
onready var ship: KinematicBody2D = get_node("../Player")
onready var explosion: AnimatedSprite = get_node("../Explosion")
onready var explosionFx: AudioStreamPlayer2D = get_node("../ExplosionFx")

func _ready():
	reset_meteor()
	
func reset_meteor():
	position.y = 0
	position.x = rand_range(10, 990)
	meteorSpeed = rand_range(350, 500)
		
func play_explosion(collider: KinematicBody2D) -> void:
	explosion.frame = 0
	explosion.play("explosion")
	explosion.position.x = collider.position.x;
	explosion.position.y = collider.position.y;
	explosionFx.play()
	
func player_collided(collider: KinematicBody2D):
	collider.position.x = outOfScreenPoint
	collider.position.y = outOfScreenPoint
	resetCounter = 4
	$"../MainTimer".start()
	
func bullet_collided(collider: KinematicBody2D):
	collider.visible = false
	collider.position.y = -100
	scoreCounter += 1
	if (scoreCounter > hiscoreCounter):
		hiscoreCounter = scoreCounter
	$"../ScoreLabel".text = "Score: " + (scoreCounter as String)
	$"../HiscoreLabel".text = "Max: " + (hiscoreCounter as String)
	
func _physics_process(delta: float) -> void:
	var velocity = Vector2()
	velocity.y += 1;
	var newVelocity = velocity.normalized() * meteorSpeed * delta
	var collision = move_and_collide(newVelocity)
	
	if position.y > bottomBorder:
		reset_meteor()
		
	if collision is KinematicCollision2D:
		reset_meteor()
		var collider: KinematicBody2D = collision.collider
		play_explosion(collider)
		
		if collider is Player:
			player_collided(collider)
			
		if collider is Bullet:
			bullet_collided(collider)
		
func _on_Timer_timeout():
	resetCounter -= 1
	var label: RichTextLabel = $"../MainLabel"
	label.text = resetCounter as String
	
	if resetCounter == 0:
		label.text = "Go!"
		ship.position.x = shipStartingX
		ship.position.y = shipStartingY
		
	if resetCounter == -1:
		$"../MainTimer".stop()
		resetCounter = 4
		scoreCounter = 0
		$"../ScoreLabel".text = "Score: 0"
		label.text = ""
		
