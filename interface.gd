extends MarginContainer

var can_energy = false

@onready var xScale = $VBoxContainer/Container/BarHolder/LifeBar.transform.get_scale().x
@onready var yScale = $VBoxContainer/Container/BarHolder/LifeBar.transform.get_scale().y

var screen_number = preload("res://screen_number.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Container/BarHolder2/EnergyBar.transform.x = Vector2(0,0)
	$VBoxContainer/Container/BarHolder2/EnergyButton.pressed.connect(_on_energy_pressed)
	for child in $VBoxContainer/HBoxContainer.get_children():
		child.pressed.connect(_on_button_pressed.bind(child))
func _on_button_pressed(button):
	Events.emit_signal("button_pressed", button)
	
func _process(delta):
	
	$HBoxContainer2/score.text = "Score: " + str(Declarations.score)
	$HBoxContainer2/combo.text = "Combo: " + str(Declarations.combo)
	
	var xx = xScale - xScale * (100 - Declarations.energy)/100
	
	if Declarations.energy < 100: 
		$VBoxContainer/Container/BarHolder2/EnergyBar.transform.x = Vector2(xx,0)
	
	if Declarations.energy >= 100 && can_energy == false:
		can_energy = true
		
	var x = xScale - xScale * (100 - Declarations.health_points)/100
	$VBoxContainer/Container/BarHolder/LifeBar.transform.x = Vector2(x,0)

func _on_energy_pressed():
	var screen_number_instance = screen_number.instantiate()
	screen_number_instance.position = get_global_mouse_position()
	if can_energy:
		Events.emit_signal("energy")
		Declarations.energy = 0
		can_energy = false
	else:
		screen_number_instance.text = "Not yet"
		add_child(screen_number_instance)
