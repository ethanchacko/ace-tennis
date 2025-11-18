class_name OppRecover extends Area2D

var can_recover := false

func _on_body_entered(body: Node2D) -> void:
	can_recover = true
