extends Sprite2D


func _ready():
	$Timer.timeout.connect(_on_timer_timeout)
	var tween = create_tween()
	tween.tween_property(self,"modulate:a",0.25,0.2)
	tween.tween_property(self,"modulate:a",0,0.2)


func _on_timer_timeout():
	self.queue_free()
