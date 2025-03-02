extends Sprite2D

var rps = -0.2
var base = self.scale[0]
var amp = 0.1
var time = 0.0
var cycle_speed = 2.0
var new_scale: float

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * cycle_speed
	new_scale = base - sin(time) * amp
	self.rotate(rps * delta)
	self.scale = Vector2(new_scale, new_scale)
