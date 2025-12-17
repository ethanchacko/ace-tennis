extends CharacterBody2D

@onready var player: CharacterBody2D = $"../player"
#@onready var ball_col: BallCollision = $"../player/ball_col"

const SPEED: int = 5

func _ready() -> void:
	velocity = Vector2(0, SPEED)

@export var can_bounce: bool = true

func _physics_process(delta: float) -> void:
	
	self.look_at(get_global_mouse_position())
	
	var collide := move_and_collide(velocity)
	
	if can_bounce == true:
		if collide:
			var normal := collide.get_normal()
			velocity = velocity.bounce(normal)
	#getting the ball to stop moving
	elif can_bounce == false:
		velocity = Vector2(0, 0)
		if Input.is_action_pressed("hit"):
			#print("Collison success")
			can_bounce = true
			var direction = Vector2.RIGHT.rotated(player.get_node("Marker2D").global_rotation)
			velocity = direction * SPEED
	
