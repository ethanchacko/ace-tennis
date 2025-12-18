extends CharacterBody2D

#@onready var ball_col: BallCollision = $"../player/ball_col"
@onready var sprint_col: SprintCollison = $"../opp/sprint_col"
@onready var opp_recover: OppRecover = $"../opp/opp_recover"
@onready var ball: CharacterBody2D = $"../Ball"
@onready var far_right: Marker2D = $"../far_right"
@onready var close_right: Marker2D = $"../close_right"
@onready var close_left: Marker2D = $"../close_left"
@onready var far_left: Marker2D = $"../far_left"
@onready var opp_detect_left: Area2D = $"../opp_detect_left"
@onready var opp_detect_right: Area2D = $"../opp_detect_right"
@onready var up_left: Marker2D = $"../up_left"
@onready var up_right: Marker2D = $"../up_right"
@onready var audio_stream_player: AudioStreamPlayer = $"../AudioStreamPlayer"







@onready var timer: Timer = $Timer

@export var recovering: bool = false
var can_recover: bool = false

var steer_force = 6700
var max_speed : float = 600.0

#var starting_location: Vector2;
var speed : float = 500

var acceleration = Vector2.ZERO
var target = null

var current_patrol_index: int = 0
var patrol_left_points: Array[Vector2]
var patrol_right_points: Array[Vector2]

var can_left : bool = false
var can_right : bool = false



func start(_transform, _target):
	global_transform = _transform 
	#rotation += randf_range(-0.09, 0.09)
	velocity = transform.x * speed 
	target = _target

func seek():
	var steer = Vector2.ZERO
	if target:
		var desired = (target - position).normalized() * speed
		steer = (desired - velocity).normalized() * steer_force
	return steer


func _ready() -> void:
	#ball = get_parent().get_node("ball")
	#starting_location = self.position;
	patrol_left_points = [close_left.position, far_left.position, up_left.position]
	patrol_right_points = [close_right.position, far_right.position, up_right.position]
	#recovering = false
	
	
func patrol(delta: float) -> void:
	
	if can_left == true:
		var target_point: Vector2 = patrol_left_points[current_patrol_index]
		var direction_to_point: Vector2 = (target_point - global_position).normalized()
		velocity = lerp(velocity, direction_to_point * speed, 5.0 * delta)
		if global_position.distance_to(target_point) < 10.0:
			current_patrol_index = (current_patrol_index + 1) % patrol_left_points.size()
			
	if can_right == true:
		var target_point: Vector2 = patrol_right_points[current_patrol_index]
		var direction_to_point: Vector2 = (target_point - global_position).normalized()
		velocity = lerp(velocity, direction_to_point * speed, 5.0 * delta)
		if global_position.distance_to(target_point) < 10.0:
			current_patrol_index = (current_patrol_index + 1) % patrol_right_points.size()


func _physics_process(delta: float) -> void:
	
	
	if recovering:
		target = null
		patrol(delta)
		
			#target = ball.position
		
	#if recovering and position.distance_to(ball.position) > 5.0:
		#target = far.position
		## Check if we're close to starting position
		#if position.distance_to(target) < 1.0:
			#can_recover = false
			#if can_recover == false:
				#speed = 0
				#timer.start()
			##recovering = false
				#timer.start() 
	#if recovering and position.distance_to(ball.position) > 5.0:
		#target = close.position
		## Check if we're close to starting position
		#if position.distance_to(target) < 1.0:
			#can_recover = false
			#if can_recover == false:
				#speed = 0
				#timer.start()
			##recovering = false
				#timer.start()
	else:
		target = ball.position
		
		
	# Use steering behavior for smooth movement to target
	acceleration += seek()
	velocity += acceleration * delta
	velocity = velocity.limit_length(max_speed)
	
	# Reset acceleration for next frame
	acceleration = Vector2.ZERO
	
	move_and_slide()
	

func _on_ball_collided_body_entered(body: Node2D) -> void:
	recovering = true
	audio_stream_player.play()
	




#func _on_timer_timeout() -> void:
	#recovering = false
	#can_recover = true
	#speed = 300


func _on_chase_detect_body_entered(body: Node2D) -> void:
	recovering = false


func _on_chase_detect_body_exited(body: Node2D) -> void:
	recovering = true


func _on_opp_detect_right_body_entered(body: Node2D) -> void:
	can_right = true


func _on_opp_detect_left_body_entered(body: Node2D) -> void:
	can_left = true


func _on_opp_detect_left_body_exited(body: Node2D) -> void:
	can_left = false


func _on_opp_detect_right_body_exited(body: Node2D) -> void:
	can_right = false
