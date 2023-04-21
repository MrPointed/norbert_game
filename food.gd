extends Area2D

var rnd = RandomNumberGenerator.new()

var speed : int

var pizza = preload("res://img/pizza_portion.png")
var sandwich = preload("res://img/sandwich.png")
var fries = preload("res://img/fries.png")
var peper = preload("res://img/peper.png")
var brocolli = preload("res://img/brocolli.png")
var muffin1 = preload("res://img/muffin.png")
var muffin2 = preload("res://img/muffin2.png")
var muffin3 = preload("res://img/muffin3.png")
var donut = preload("res://img/donna.png")
var pumpkin = preload("res://img/pumpkin.png")
var carrot = preload("res://img/carrot.png")
var lemon = preload("res://img/lemon.png")

var beans = preload("res://img/beans.png")
var cocacola = preload("res://img/drink.png")
var chilly = preload("res://img/chilly.png")

var special := false
var food_type
var rot

# Called when the node enters the scene tree for the first time.
func _ready():
	$VisibleOnScreenNotifier2D.screen_exited.connect(_on_screen_exited)
	area_entered.connect(_on_area_entered)
	
	rnd.randomize()
	rot = rnd.randf_range(-0.05, 0.05)
	
	var random_number = rnd.randi_range(0, 2)
	match random_number:
		0,1: food_type = Declarations.GOOD #60%
		2: food_type = Declarations.BAD #30%
	
	rnd.randomize()
	if food_type == Declarations.GOOD:
		random_number = rnd.randi_range(0, 19)
		match random_number:
			0: food_type = Declarations.HEALER #re-declaration
			_: food_type = food_type #it keeps it's old property
	elif food_type == Declarations.BAD:
		random_number = rnd.randi_range(0, 9)
		match random_number:
			0: food_type = Declarations.SPICY # % re-declaration
			1: food_type = Declarations.FART
			_: food_type = food_type #it keeps it's old property
			
	if food_type == Declarations.HEALER:
		$Sprite2D.set_texture(cocacola)
	if food_type == Declarations.SPICY:
		$Sprite2D.set_texture(chilly)
	if food_type == Declarations.FART:
		$Sprite2D.set_texture(beans)
	
	match Declarations.level:
		1: 
			speed = 300
			if food_type == Declarations.GOOD:
				$Sprite2D.set_texture(sandwich)
			elif food_type == Declarations.BAD:
				$Sprite2D.set_texture(peper)
		2: 
			speed = 400
			if food_type == Declarations.GOOD:
				$Sprite2D.set_texture(sandwich)
			elif food_type == Declarations.BAD:
				$Sprite2D.set_texture(peper)
		3: 
			speed = 500
			rnd.randomize()
			if food_type == Declarations.GOOD:
				$Sprite2D.set_texture(sandwich)
			elif food_type == Declarations.BAD:
				random_number = rnd.randi_range(0, 1)
				match random_number:
					0: $Sprite2D.set_texture(peper)
					1: $Sprite2D.set_texture(brocolli)
		4: 
			speed = 600
			rnd.randomize()
			if food_type == Declarations.GOOD:
				random_number = rnd.randi_range(0, 1)
				match random_number:
					0: $Sprite2D.set_texture(pizza)
					1: $Sprite2D.set_texture(sandwich)
			elif food_type == Declarations.BAD:
				random_number = rnd.randi_range(0, 1)
				match random_number:
					0: $Sprite2D.set_texture(peper)
					1: $Sprite2D.set_texture(brocolli)

		5: 
			speed = 900
			rnd.randomize()
			if food_type == Declarations.GOOD:
				random_number = rnd.randi_range(0, 1)
				match random_number:
					0: $Sprite2D.set_texture(pizza)
					1: $Sprite2D.set_texture(sandwich)
			elif food_type == Declarations.BAD:
				random_number = rnd.randi_range(0, 1)
				match random_number:
					0: $Sprite2D.set_texture(peper)
					1: $Sprite2D.set_texture(brocolli)
					
		6: 
			speed = 500
			rnd.randomize()
			if food_type == Declarations.GOOD:
				random_number = rnd.randi_range(0, 1)
				match random_number:
					0: $Sprite2D.set_texture(muffin1)
					1: $Sprite2D.set_texture(muffin2)
			elif food_type == Declarations.BAD:
				$Sprite2D.set_texture(pumpkin)

		7: 
			speed = 700
			rnd.randomize()
			if food_type == Declarations.GOOD:
				random_number = rnd.randi_range(0, 3)
				match random_number:
					0: $Sprite2D.set_texture(muffin1)
					1: $Sprite2D.set_texture(muffin2)
					2: $Sprite2D.set_texture(muffin3)
					3: $Sprite2D.set_texture(donut)
			elif food_type == Declarations.BAD:
				random_number = rnd.randi_range(0, 1)
				match random_number:
					0: $Sprite2D.set_texture(pumpkin)
					1: $Sprite2D.set_texture(carrot)
					
		8: 
			speed = 900
			rnd.randomize()
			if food_type == Declarations.GOOD:
				random_number = rnd.randi_range(0, 3)
				match random_number:
					0: $Sprite2D.set_texture(muffin1)
					1: $Sprite2D.set_texture(muffin2)
					2: $Sprite2D.set_texture(muffin3)
					3: $Sprite2D.set_texture(donut)
			elif food_type == Declarations.BAD:
				random_number = rnd.randi_range(0, 1)
				match random_number:
					0: $Sprite2D.set_texture(pumpkin)
					1: $Sprite2D.set_texture(carrot)

		9: 
			speed = 1100
			rnd.randomize()
			if food_type == Declarations.GOOD:
				random_number = rnd.randi_range(0, 3)
				match random_number:
					0: $Sprite2D.set_texture(muffin1)
					1: $Sprite2D.set_texture(muffin2)
					2: $Sprite2D.set_texture(muffin3)
					3: $Sprite2D.set_texture(donut)
			elif food_type == Declarations.BAD:
				random_number = rnd.randi_range(0, 2)
				match random_number:
					0: $Sprite2D.set_texture(pumpkin)
					1: $Sprite2D.set_texture(carrot)
					2: $Sprite2D.set_texture(lemon)
					

func _process(delta):
	position += Vector2.DOWN * delta * speed
	rotation += rot
	
	if Declarations.energy_state:
		$Sprite2D.modulate = Color(2,2,0,0.9)
	else:
		$Sprite2D.modulate = Color(1,1,1,1)

func _on_area_entered(area):
	if area.name == "player":
		Events.emit_signal("eaten_food", self)


func _on_screen_exited():
	self.queue_free()
