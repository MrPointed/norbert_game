extends Area2D



func _input(event):

	if event.is_action_pressed("1"):
		position = Vector2(Declarations.first_pos,960)
	elif event.is_action_pressed("2"):
		position = Vector2(Declarations.second_pos,960)
	elif event.is_action_pressed("3"):
		position = Vector2(Declarations.third_pos,960)
	elif event.is_action_pressed("4"):
		position = Vector2(Declarations.fourth_pos,960)


func _ready():
	randomize()
	Events.button_pressed.connect(_on_button_pressed)
	$AnimationPlayer.play("idle")
	$AnimationPlayer.animation_finished.connect(_on_animation_finished)
	$AnimationPlayer.animation_started.connect(_on_animation_started)

func _on_animation_started(anim):
	if anim == "mask":
		Declarations.mask_state = true

func _on_animation_finished(anim):
	if anim == "ugly":
		$AnimationPlayer.play("idle")
		
	if anim == "mask":
		$AnimationPlayer.play("idle")
		Declarations.mask_state = false

func _process(_delta):
	pass

func _on_button_pressed(button):
	match button.name:
		"1": position = Vector2(Declarations.first_pos,960)
		"2": position = Vector2(Declarations.second_pos,960)
		"3": position = Vector2(Declarations.third_pos,960)
		"4": position = Vector2(Declarations.fourth_pos,960)
	
