extends KinematicBody2D

export var speed = 1000.0

var car_textures

func _ready():
	randomize()
	
	car_textures = get_car_sprites()
	
	# Choose a random texture
	var random_index = randi() % car_textures.size()
	var car_texture_chosen = car_textures[random_index]
	
	$Sprite.texture = car_texture_chosen

func _process(delta):
	move_and_slide(Vector2(-speed * delta, 0.0))

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func get_car_sprites():
	# This is an ugly way of getting cars, could possibly be refactored
	
	var car_textures_result = []
	var cars_directory = "res://sprites/cars/"
	
	for i in range(1, 16):
		var car_texture = load(cars_directory + "car" + str(i) + ".png")
		car_textures_result.append(car_texture)
		
	return car_textures_result
	
