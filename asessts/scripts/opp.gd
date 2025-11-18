extends CharacterBody2D

@onready var ball_col: BallCollision = $"../player/ball_col"
@onready var sprint_col: SprintCollison = $"../opp/sprint_col"
@onready var opp_recover: OppRecover = $"../opp/opp_recover"

var starting_location: Vector2;

var ball : CharacterBody2D
var SPEED : float = 150

func _ready() -> void:
	ball = get_parent().get_node("ball")
	starting_location = self.position;
	
func _physics_process(delta: float) -> void:
	
	if Input.is_action_pressed("hit"):
			#print("opp")
			ball_col.can_bounce = true
			SPEED = 150
			
	if sprint_col.can_sprint == true:
		SPEED = 250
	elif sprint_col.can_sprint == false:
		SPEED = 150
		
	if opp_recover.can_recover == true: #and ball_col.can_bounce == true:
		global_position = global_position.move_toward(starting_location, 2)

	elif opp_recover.can_recover == false:
		if ball_col.can_bounce == true:
			var dir = position.direction_to(ball.global_position).normalized()
			velocity = dir * SPEED
			move_and_slide()
		elif ball_col.can_bounce == false:
			SPEED = 0
		
	#global_position.x = ball.global_position.x

	 
