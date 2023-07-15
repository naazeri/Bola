extends RigidBody2D

var speedLimit := 3000
var acceleration = 300


func _ready():
	pass  # Replace with function body.


#func _process(delta):
#	pass


func _physics_process(_delta):
	limitSpeed()


func limitSpeed():
	if linear_velocity.x > speedLimit:
		linear_velocity.x -= acceleration

	if linear_velocity.x < -speedLimit:
		linear_velocity.x += acceleration

	if linear_velocity.y > speedLimit:
		linear_velocity.y -= acceleration

	if linear_velocity.y < -speedLimit:
		linear_velocity.y += acceleration
