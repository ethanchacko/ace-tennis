class_name BallCollision extends Area2D

var can_bounce := true

func _on_body_entered(body: Node2D) -> void:
	can_bounce = false
	
