extends KinematicBody2D

# onready var startPosition := $StartPosition
var mouse_position := Vector2.ZERO
# var screen_size := Vector2.ZERO

# func _ready():
# 	screen_size = get_viewport_rect().size
# 	print(screen_size)


func _process(_delta):
	handleInput()
	# move()


func _physics_process(_delta):
	move()


func handleInput():
	mouse_position = get_viewport().get_mouse_position()


func move():
	position = mouse_position

	# limit position to screen area
	# position.x = clamp(position.x, 0, screen_size.x)
	# position.y = clamp(position.y, 0, screen_size.y)
