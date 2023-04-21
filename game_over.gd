extends MarginContainer

@onready var restart_btn = $Gamover/restart_btn
@onready var exit_btn = $Gamover/exit_btn


func _ready():
	restart_btn.input_event.connect(_on_input_event)
	$Gamover/score_lbl.text = "Score: " + str(Declarations.score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_input_event(viewport,event,shapeidx):
	if event.is_action_pressed("press"):
		Events.emit_signal("restart")
		self.queue_free()
