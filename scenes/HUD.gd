extends CanvasLayer

signal reset_game

func _on_Button_pressed():
	emit_signal("reset_game")

func _on_MainMenuButton_pressed():
	get_tree().change_scene("res://scenes/MainMenu.tscn")
