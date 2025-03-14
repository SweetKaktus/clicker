extends Node2D


var snowballs_collected: int
var manual_progress_step: int = 1
var automatic_progress_step: int = 0

@onready var snowball: TextureButton = $Control/snowball
@onready var counter: Label = $Control/snowballs_collected/counter
@onready var progress_bar: TextureProgressBar = $Control/snowballs_collected/ProgressBar

var regular_size: Vector2
var pressed_size: Vector2

var regular_position: Vector2
var pressed_position: Vector2

func _ready() -> void:
	snowballs_collected = 0
	progress_bar.value = 0
	manual_progress_step = 1
	automatic_progress_step = 0
	regular_position = snowball.position
	pressed_position = snowball.position + Vector2(4, 4)
	regular_size = snowball.size
	pressed_size = snowball.size - Vector2(8, 8)
	update_counter()
	
	
func _on_texture_button_button_up() -> void:
	snowball.size = regular_size
	snowball.position = regular_position
	progress_bar.value += manual_progress_step
	update_counter()

func update_counter() -> void:
	counter.text = str(snowballs_collected)


func _on_texture_button_button_down() -> void:
	snowball.size = pressed_size
	snowball.position = pressed_position




func _on_progress_bar_value_changed(value: float) -> void:
	if value >= 100:
		progress_bar.value = 0
		snowballs_collected += 1
		update_counter()
		
