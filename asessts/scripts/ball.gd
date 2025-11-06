extends CharacterBody2D

@onready var ball_col: BallCollision = $"../player/ball_col"

const SPEED: int = 5

func _ready() -> void:
	velocity = Vector2(0, SPEED)
	

func _physics_process(delta: float) -> void:
	var collide := move_and_collide(velocity)
	
	if ball_col.can_bounce == true:
		if collide:
			var normal := collide.get_normal()
			velocity = velocity.bounce(normal)
	#getting the ball to stop moving
	elif ball_col.can_bounce == false:
		velocity = Vector2(0, 0)
		if Input.is_action_pressed("hit"):
			#print("Collison success")
			ball_col.can_bounce = true
			velocity = Vector2(0, SPEED)
	
	
