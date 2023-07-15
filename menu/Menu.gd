extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass  # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_StartButton_button_up():
	# OS.set_window_fullscreen(!OS.window_fullscreen)
	get_tree().change_scene("res://game/Game.tscn")


func _on_AboutButton_button_up():
	get_tree().change_scene("res://about/About.tscn")


func _on_ExitButton_button_up():
	# if OS.window_fullscreen and OS.get_name() == "HTML5":
	# 	OS.set_window_fullscreen(false)

	get_tree().quit()
