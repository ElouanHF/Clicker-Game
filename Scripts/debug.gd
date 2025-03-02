extends Button

var controller: Node2D

func _ready() -> void:
	controller = get_tree().get_nodes_in_group("Controller")[0]

func _pressed() -> void:
	controller.clicks *= 10
