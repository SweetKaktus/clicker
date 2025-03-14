extends Node2D


var snowballs_collected: int

@onready var snowball: TextureButton = $Control/snowball
@onready var counter: Label = $Control/snowballs_collected/counter

var regular_size: Vector2
var pressed_size: Vector2

var regular_position: Vector2
var pressed_position: Vector2

func _ready() -> void:
	snowballs_collected = 0
	regular_position = snowball.position
	pressed_position = snowball.position + Vector2(4, 4)
	regular_size = snowball.size
	pressed_size = snowball.size - Vector2(8, 8)
	update_counter()
	
	
func _on_texture_button_button_up() -> void:
	snowball.size = regular_size
	snowball.position = regular_position
	snowballs_collected += 1
	update_counter()

func update_counter() -> void:
	counter.text = str(snowballs_collected)


func _on_texture_button_button_down() -> void:
	snowball.size = pressed_size
	snowball.position = pressed_position
