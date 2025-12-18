extends CharacterBody2D

@onready var marker_2d: Marker2D = $Marker2D
@onready var ball: CharacterBody2D = $"../Ball"

var drag: float = 100;
var acceleration := 500
var turn_speed: float = 1000;
var can_move : bool = true
var score := 0

func getXDir() -> float:
	var x = Input.get_action_strength("right") - Input.get_action_strength("left")
	return x

func getYDir()-> float:
	return Input.get_action_strength("down") - Input.get_action_strength("up")
	



func _physics_process(delta: float) -> void:
	if can_move == false:
		velocity = Vector2(0,0);
	else:
		var dir: Vector2 = Vector2(getXDir(), getYDir());
		if(dir != Vector2.ZERO):
			velocity = velocity.move_toward(dir * acceleration, turn_speed * delta)
			#dir * SPEED
	
	velocity = velocity.move_toward(Vector2.ZERO, drag * delta)

	move_and_slide()
	marker_2d.look_at(get_global_mouse_position())
	

		
func _on_ball_collision_body_entered(body: Node2D) -> void:
	if body.is_in_group("ball"):
		can_move = false
		body.can_bounce = false
		
		
	#print("collided with something")


func _on_ball_collision_body_exited(body: Node2D) -> void:
	can_move = true


func _on_score_body_entered(body: Node2D) -> void:
	score = score + 1
	print("Score: ", score)
