extends Label


func _ready():
	position.y = get_viewport().size.y/2 - get_viewport().size.y/5
	var tween = create_tween()
	tween.tween_property(self, "position:x", get_viewport().size.x/2 - get_viewport().size.x/5,1).set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT)
	tween.tween_interval(0.5)
	tween.tween_property(self, "position:x", get_viewport().size.x , 0.2).set_ease(Tween.EASE_OUT)
	tween.tween_callback(queue_free)

