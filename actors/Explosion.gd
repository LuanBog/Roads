extends StaticBody2D

func _ready():
	$AnimationPlayer.current_animation = "Explode"

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
