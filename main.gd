extends Node2D

var food = preload("res://food.tscn")
var game_over_scn = preload("res://game_over.tscn")

var song1 = preload("res://songs/song1.mp3")
var song2 = preload("res://songs/song2.mp3")

var screen_number = preload("res://screen_number.tscn")
var combo_lbl = preload('res://combo_lbl.tscn')

var effect_frame = preload("res://effect_frame.tscn")

var bite_sound = preload("res://songs/bite_sound.mp3")
var eat_sound = preload("res://songs/eat_sound.mp3")
var munch_sound = preload("res://songs/munch_sound.mp3")

var fart = preload("res://fart.tscn").instantiate()
var fart1 = preload("res://songs/fart1.mp3")
var fart3 = preload("res://songs/fart3.mp3")

var drink_sound = preload("res://songs/drink_effect.mp3")

var black_bg = preload("res://gui/black_bg.jpeg")
var wood_bg = preload("res://gui/yellow_bg.jpeg")
var metal = preload("res://gui/metal.png")

var rnd = RandomNumberGenerator.new()

var belly_scale : float = 1


func _input(event):
	if event.is_action_pressed("ui_accept"):
		print(get_child(1).name)

func _ready():
	$player.add_child(fart)
	play_aletory_song()
	$background_song.finished.connect(play_aletory_song)
	$Area2D.area_entered.connect(_on_body_entered)
	$spawnTimer.timeout.connect(_on_spawn_timeout)
	$energyTimer.timeout.connect(_on_energy_timeout)
	
	Events.eaten_food.connect(_on_food_eaten)
	Events.restart.connect(_on_restart)
	Events.game_over.connect(_on_game_over)
	Events.energy.connect(_on_energy)
	$player.position = Vector2(90 ,960)
	get_child(0).position = Vector2(720/2, 1280/2)
	$Marco.position = Vector2(720/2, 1280/2)
	$interface.position = Vector2(0,0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
	if Declarations.health_points <= 0:
		print("game over")
		Events.emit_signal("game_over")
		
	if Declarations.combo - Declarations.last_combo == 20:
		var combo_lbl_instance = combo_lbl.instantiate()
		if Declarations.combo > 100:
			combo_lbl_instance.text = "Incredible! x" + str(Declarations.combo)
		else: 
			combo_lbl_instance.text = "Good! x" + str(Declarations.combo)
		add_child(combo_lbl_instance)
		Declarations.last_combo = Declarations.combo
	
	
	match Declarations.level:
		1:
			if Declarations.score - Declarations.score_tracker == 200:
				Declarations.level += 1
				Declarations.score_tracker = Declarations.score
			$spawnTimer.set_wait_time(1.3)
		2:
			if Declarations.score - Declarations.score_tracker == 300:
				Declarations.level += 1
				Declarations.score_tracker = Declarations.score
			$spawnTimer.set_wait_time(0.8)
		3:
			if Declarations.score - Declarations.score_tracker == 400:
				Declarations.level += 1
				Declarations.score_tracker = Declarations.score
			$spawnTimer.wait_time = 0.6
		4:
			if Declarations.score - Declarations.score_tracker == 500:
				Declarations.level += 1
				Declarations.score_tracker = Declarations.score
			$spawnTimer.wait_time = 0.5
		5:
			if Declarations.score - Declarations.score_tracker == 600:
				Declarations.level += 1
				Declarations.score_tracker = Declarations.score
				change_background(black_bg) #if level 6
			$spawnTimer.wait_time = 0.4
			
		6:
			if Declarations.score - Declarations.score_tracker == 400:
				Declarations.level += 1
				Declarations.score_tracker = Declarations.score
			$spawnTimer.wait_time = 0.6

		7:
			if Declarations.score - Declarations.score_tracker == 500:
				Declarations.level += 1
				Declarations.score_tracker = Declarations.score
			$spawnTimer.wait_time = 0.5
			
		8:
			if Declarations.score - Declarations.score_tracker == 600:
				Declarations.level += 1
				Declarations.score_tracker = Declarations.score
			$spawnTimer.wait_time = 0.4
			
		9:
			if Declarations.score - Declarations.score_tracker == 800:
				Declarations.level += 1
				Declarations.score_tracker = Declarations.score
			$spawnTimer.wait_time = 0.3

func _on_energy_timeout():
	Declarations.energy_state = false

func _on_energy():
	Declarations.energy_state = true
	$energyTimer.start()

func _on_restart():
	Declarations.health_points = 100
	Declarations.energy = 0
	Declarations.level = 1
	Declarations.score = 0
	Declarations.score_tracker = 0
	Declarations.energy_state = false
	belly_scale = 1
	$player/Marker2D/belly.scale = Vector2.ONE * belly_scale
	change_background(wood_bg)
	set_process(true)
	$spawnTimer.start()

func _on_game_over():
	add_child(game_over_scn.instantiate())
	$spawnTimer.stop()
	set_process(false)
	
func _on_body_entered(food): #lower bar to detect if a food passed
	
	if Declarations.energy_state:
		return
	
	var screen_number_instance = screen_number.instantiate()
	screen_number_instance.position = food.position
	
	var effect_frame_instance = effect_frame.instantiate()
	
	
	if food.food_type == Declarations.GOOD:
		Declarations.health_points -= 10
		Declarations.combo = 0
		Declarations.last_combo = 0
		
		screen_number_instance.text = "-10"
		screen_number_instance.modulate = Color.RED
		
		effect_frame_instance.modulate = Color(255,0,0,0)
		
		add_child(effect_frame_instance)
		add_child(screen_number_instance)
	
func _on_spawn_timeout():
	spawn_food()
	
func _on_food_eaten(food):
	
	if Declarations.mask_state: return
	
	belly_scale += 0.01
	var screen_number_instance = screen_number.instantiate()
	screen_number_instance.position = food.position
	
	var effect_frame_instance = effect_frame.instantiate()
	
	var random_number = randi_range(0,2)
	
	$eat_effect.volume_db = 0

	match random_number:
		0:
			$eat_effect.set_stream(bite_sound)
			$fart_sound.set_stream(fart1)
		1:
			$eat_effect.set_stream(eat_sound)
			$fart_sound.set_stream(fart3)
		2: 
			$eat_effect.set_stream(munch_sound)
			$fart_sound.set_stream(fart3)


	if food.food_type == Declarations.GOOD:
		Declarations.score += 10
		Declarations.energy += 10
		Declarations.combo += 1
		
		screen_number_instance.text = "+10"
		screen_number_instance.modulate = Color.WHITE
		effect_frame_instance.visible = false
		
	if food.food_type == Declarations.BAD:
		if Declarations.energy_state:
			Declarations.score += 10
			effect_frame_instance.visible = false
			screen_number_instance.text = "+10"
			screen_number_instance.modulate = Color.WHITE
		else:
			Declarations.health_points -= 10
			Declarations.combo = 0
			Declarations.last_combo = 0
			screen_number_instance.text = "-10"
			screen_number_instance.modulate = Color.RED
			effect_frame_instance.modulate = Color(255,0,0,0)
			$player/AnimationPlayer.play("ugly")
		
	if food.food_type == Declarations.HEALER:
		if Declarations.health_points < 100:
			if Declarations.energy_state:
				Declarations.score += 10
				effect_frame_instance.visible = false
				screen_number_instance.text = "+10"
				screen_number_instance.modulate = Color.WHITE
			else:
				Declarations.health_points += 10
				screen_number_instance.text = "+10"
				screen_number_instance.modulate = Color.GREEN
				effect_frame_instance.modulate = Color(0,255,0,0)
		else:
			effect_frame_instance.visible = false
		Declarations.combo += 1
		$eat_effect.set_stream(drink_sound)
		#turn the screen with a green frame effect
		
	if food.food_type == Declarations.SPICY:
		if Declarations.energy_state:
			Declarations.score += 10
			effect_frame_instance.visible = false
			screen_number_instance.text = "+10"
			screen_number_instance.modulate = Color.WHITE
		else:
			Declarations.health_points -= 20
			Declarations.combo = 0
			Declarations.last_combo = 0
			screen_number_instance.text = "-20"
			screen_number_instance.modulate = Color.RED
			effect_frame_instance.modulate = Color(255,0,0,0)
			#add ayayayay sound effect
			$player/AnimationPlayer.play("mask")
		
	if food.food_type == Declarations.FART:
		if Declarations.energy_state:
			Declarations.score += 10
			effect_frame_instance.visible = false
			screen_number_instance.text = "+10"
			screen_number_instance.modulate = Color.WHITE
		else:
			Declarations.health_points -= 5
			Declarations.combo = 0
			Declarations.last_combo = 0
			screen_number_instance.text = "Puh Diablo!"
			screen_number_instance.modulate = Color.GREEN_YELLOW
			effect_frame_instance.modulate = Color(255,0,0,0)
			fart.amount = 2 + (belly_scale - 1) * 40
			fart.emitting = true
			$fart_sound.play()
			$eat_effect.volume_db = -80 #to make the fart louder
			$player/AnimationPlayer.play("ugly")
			belly_scale = 1
		
		
	if belly_scale < 1.5:
		$player/Marker2D/belly.scale = Vector2.ONE * belly_scale

	add_child(screen_number_instance)
	$interface.add_child(effect_frame_instance)
	$eat_effect.play()
	food.queue_free()

func spawn_food():
	rnd.randomize()
	var food_instance = food.instantiate()
	add_child(food_instance)
	
	var random_number = rnd.randi_range(1, 4)

	match random_number:
		1: food_instance.position = Vector2(Declarations.first_pos,0)
		2: food_instance.position = Vector2(Declarations.second_pos,0)
		3: food_instance.position = Vector2(Declarations.third_pos,0)
		4: food_instance.position = Vector2(Declarations.fourth_pos,0)

func play_aletory_song():
	rnd.randomize()
	var random_value = rnd.randi_range(0,1)
	match random_value:
		0:	$background_song.stream = song1
		1:	$background_song.stream = song2
	$background_song.play()
	
func change_background(newtexture):
	get_child(0).set_texture(newtexture)
	var tween = create_tween()
	tween.tween_property(get_child(1),"modulate:a", 0, 3)
	tween.tween_callback(move_child.bind(get_child(0), 1))
	tween.tween_callback(get_child(1).set_modulate.bind(Color.WHITE))
