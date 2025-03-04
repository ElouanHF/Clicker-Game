extends Node2D

var clicks: float = 0
var clicks_to_av: int = 0
var av_time: float = 3
var cps: float 
var auto_clicks_ps: float = 0
var tcps: float

var cost_scale: float = 1.1

var items = {
	"Clicks": {"Prod": 1},
	"Picks": {"Num": 0, "Cost": 10, "Prod": 0.5},
	"Drills": {"Num": 0, "Cost": 250, "Prod": 10},
	"Lasers": {"Num": 0, "Cost": 5000, "Prod": 150},
	"Nukes": {"Num": 0, "Cost": 100000, "Prod": 2000},
	"Death Stars": {"Num": 0, "Cost": 2500000, "Prod": 25000},
}

var upgrades = {
	"Clicks": {"Num": 0, "Cost": 100, "Scale": 2.1},
	"Picks": {"Num": 0, "Cost": 1000, "Scale": 2.5},
	"Drills": {"Num": 0, "Cost": 20000, "Scale": 2.5},
	"Lasers": {"Num": 0, "Cost": 50000, "Scale": 2.5},
	"Nukes": {"Num": 0, "Cost": 2000000, "Scale": 2.5},
	"Death Stars": {"Num": 0, "Cost": 10000000, "Scale": 2.5},
}

func _process(delta: float) -> void:
	clicks += auto_clicks_ps * delta
	cps = clicks_to_av / av_time
	tcps = cps + auto_clicks_ps

func _recalc_acps() -> void:
	var item_clicks = 0
	for item in items.keys():
		if item != "Clicks":
			item_clicks += items[item]["Num"] * items[item]["Prod"]
	auto_clicks_ps = item_clicks

func add_item(item: String) -> void:
	if self._can_buy(items[item]["Cost"]):
		items[item]["Num"] += 1
		clicks -= items[item]["Cost"]
		items[item]["Cost"] *= cost_scale
		_recalc_acps()

func add_upgrade(upgrade: String) -> void:
	if self._can_buy(upgrades[upgrade]["Cost"]):
		upgrades[upgrade]["Num"] += 1
		clicks -= upgrades[upgrade]["Cost"]
		upgrades[upgrade]["Cost"] *= upgrades[upgrade]["Scale"]
		items[upgrade]["Prod"] *= 2
		_update_items()
		_recalc_acps()

func _update_items() -> void:
	get_tree().call_group("Items", "update")

func _can_buy(cost):
	return clicks >= cost
