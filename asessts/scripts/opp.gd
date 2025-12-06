extends CharacterBody2D

#@onready var ball_col: BallCollision = $"../player/ball_col"
@onready var sprint_col: SprintCollison = $"../opp/sprint_col"
@onready var opp_recover: OppRecover = $"../opp/opp_recover"
@onready var ball: CharacterBody2D = $"../Ball"

@onready var timer: Timer = $Timer

@export var recovering: bool = false

var steer_force = 50.0

var starting_location: Vector2;
var speed : float = 200

var acceleration = Vector2.ZERO
var target = ball

func start(_transform, _target):
	global_transform = _transform 
	rotation += randf_range(-0.09, 0.09)
	velocity = transform.x * speed 
	target = _target

func seek():
	var steer = Vector2.ZERO
	print("seek")
	if target:
		var desired = (target.position - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
		print(desired)
		print(steer)
	return steer


func _ready() -> void:
	#ball = get_parent().get_node("ball")
	starting_location = self.position;


func _physics_process(delta: float) -> void:
	
	if global_position == starting_location and ball.can_bounce == false:
		recovering = false
		
	if recovering == true: #and ball_col.can_bounce == true:
		global_position = global_position.move_toward(starting_location, 2)
		
	else:
		if ball.can_bounce == true:
			print(acceleration)
			print(velocity)
			print(speed)
			speed = 200
			acceleration += seek()
			velocity += acceleration * delta
			rotation = velocity.angle()
			position += velocity * delta
			#speed = 200
			#var dir = position.direction_to(ball.global_position).normalized()
			#velocity = dir * speed
			
		elif ball.can_bounce == false:
			speed = 0
	move_and_slide()

func _on_ball_collided_body_entered(body: Node2D) -> void:
	recovering = true
