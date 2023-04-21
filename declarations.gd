extends Node

enum{GOOD, BAD, SPICY, HEALER, FART} #food_type


var first_pos = 90
var second_pos = 270
var third_pos = 450
var fourth_pos = 630

var health_points = 100
var energy : int
var score : int

var combo : int = 0
var last_combo : int = 0

var level : int = 5
var score_tracker : int = 0 

var energy_state = false
var mask_state = false
