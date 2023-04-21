extends Label



func _ready():
	$Timer.timeout.connect(_on_timer_timeout)

func _process(delta):
	position.y += -100 * delta
	self.modulate.a -= 0.5 * delta

func _on_timer_timeout():
	self.queue_free()
