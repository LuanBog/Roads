extends Area2D

signal death(final_position)

func _on_Player_body_entered(body):
	body.queue_free()
	
	emit_signal("death", self.position)
	queue_free()
