extends CharacterBody2D

@onready var marker_2d: Marker2D = $Marker2D

const SPEED := 200

func getXDir() -> float:
	return Input.get_action_strength("right") - Input.get_action_strength("left")

func getYDir()-> float:
	return Input.get_action_strength("down") - Input.get_action_strength("up")
	

func _physics_process(delta: float) -> void:
	var dir :Vector2=Vector2(getXDir(), getYDir())
	velocity = dir * SPEED
	move_and_slide()
	marker_2d.look_at(get_global_mouse_position())
