extends Node2D

export(PackedScene) var itemScene

onready var timer := $Timer
onready var item: Area2D = $Item
onready var scoreLabel := $ScoreLabel
onready var bestScoreLabel := $BestScoreLabel
onready var successAudioPlayer := $Item/AudioPlayer
onready var fullscreenArea := $FullscreenArea

const itemRadius := 67

var score := 0
var bestScore := 0
var isItemActive := true
var screenSize := Vector2.ZERO

# Save game
const saveFilePath := "user://savegame.save"
const bestScoreKey := "bestScore"


func _ready():
	randomize()
	screenSize = get_viewport_rect().size

	timer.start()
	moveItem()

	# Mouse
	config_mouse_cursor()

	# Score
	loadBestScore()
	updateScoreUI()
	updateBestScoreUI()


func _on_Timer_timeout():
	moveItem()


func _on_Item_body_entered(body: Node):
	if isItemActive and body.name == "Ball":
		setItemActive(false)

		updateScore()

		# play sound
		successAudioPlayer.play()


func _unhandled_input(event):
	handleExitGame(event)


func config_mouse_cursor():
	# confines the cursor to the game window
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	# Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)

	# set mouse position to player position. so cursor and player position synced
	# Input.warp_mouse_position(startPosition.position)


func setItemActive(status: bool):
	isItemActive = status
	item.visible = status
	set_process(status)
	set_physics_process(status)
	set_process_input(status)


func moveItem():
	item.position = Vector2(
		rand_range(itemRadius, screenSize.x - itemRadius),
		rand_range(itemRadius, screenSize.y - itemRadius)
	)
	setItemActive(true)


func updateScore():
	score += 1
	updateScoreUI()

	if needSaveBestScore():
		bestScore = score
		saveBestScore()
		updateBestScoreUI()


func updateScoreUI():
	scoreLabel.text = str("Score: ", score)


func updateBestScoreUI():
	bestScoreLabel.text = str("Best Score: ", bestScore)


func handleExitGame(event):
	if event is InputEventKey and event.scancode == KEY_ESCAPE and event.pressed:
		get_tree().quit(0)


func loadBestScore():
	var saveFile := File.new()

	if not saveFile.file_exists(saveFilePath):
		bestScore = 0
		return

	var isOpened := saveFile.open(saveFilePath, File.READ)

	if isOpened != OK:
		print("cant open save file in load")
		return

	var data = saveFile.get_var(true)

	if data != null:
		bestScore = data[bestScoreKey]
	else:
		bestScore = 0

	saveFile.close()


func saveBestScore():
	var data := Dictionary()
	data[bestScoreKey] = score

	var saveFile := File.new()
	var isOpened := saveFile.open(saveFilePath, File.WRITE)

	if isOpened == OK:
		saveFile.store_var(data, true)
		saveFile.close()
	else:
		print("cant open save file")


func needSaveBestScore():
	return score > bestScore
