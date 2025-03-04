extends Area2D

var node: Node2D
var parent: Node2D
var size: float
var shrink = 0.9
var is_pressed = false


func _ready() -> void:
	node = self.get_child(0)
	parent = self.get_parent()
	size = node.scale[0]


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
		
func _input(event):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_released() and is_pressed:
		self.on_release()

func _delay(time: int, function: Callable):
	await get_tree().create_timer(time).timeout
	function.call()

func on_click():
	print("Click")
	is_pressed = true
	node.scale = Vector2(size * shrink, size * shrink)
	parent.clicks += parent.items["Clicks"]["Prod"]
	parent.clicks_to_av += parent.items["Clicks"]["Prod"]
	_delay(parent.av_time, decrease_cps)

func on_release():
	print("Release")
	is_pressed = false
	node.scale = Vector2(size, size)

func decrease_cps():
	parent.clicks_to_av -= parent.items["Clicks"]["Prod"]
