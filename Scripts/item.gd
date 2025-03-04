extends Button

var controller: Node2D
var item: String

func _ready() -> void:
	item = self.get_meta("item")
	controller = get_tree().get_nodes_in_group("Controller")[0]
	self.update()

func _pressed() -> void:
	controller.add_item(item)
	self.update()

func update() -> void:
	self.text = item +\
			" (" + str(add_comma(controller.items[item]["Num"])) +\
			"):\nCost " + str(add_comma(snapped(controller.items[item]["Cost"], 0.1))) +\
			"\nProd " +\
			str(add_comma(controller.items[item]["Prod"])) 
	
func add_comma(value: float) -> String:
	# Convert value to string.
	var str_value: String = str(snapped(value, 0.1))
	
	# Check if the value is positive or negative.
	# Use index 0(excluded) if positive to avoid comma at the beginning.
	# Use index 1(excluded) if negative to avoid comma after the - sign.
	var loop_end: int = 0 if value > -0.001 else 1
	
	# Set default value to 3 since commas has interval of 3.
	var loop_start: int = 3
	
	# Look for the decimal point by looping backward.
	# Use this when the characters of the decimal part
	# are lower than the whole number part.
	for i in range(str_value.length()-1, -1, -1):
		if str_value[i] == ".":
			loop_start += (str_value.length() - i)
			break;

	# Loop to look for the decimal point.
	# Use this when the characters of the decimal part
	# are more than the whole number part.
#	for i in str_value.length():
#		if str_value[i] == ".":
#			loop_start += (str_value.length() - i)
#			break;
	
	# Loop backward starting at the last 3 digits of the whole number,
	# add comma then, repeat every 3rd step.
	for i in range(str_value.length()-loop_start, loop_end, -3):
		str_value = str_value.insert(i, ",")
	
	# Return the formatted string.
	return str_value
