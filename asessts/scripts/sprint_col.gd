class_name SprintCollison extends Area2D

var can_sprint := false

func _on_body_entered(body: Node2D) -> void:
	can_sprint = true


func _on_body_exited(body: Node2D) -> void:
	can_sprint = false # Replace with function body.
