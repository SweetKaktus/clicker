extends Node2D


var snowballs_collected: int
var manual_progress_step: int = 1
var automatic_progress_step: int = 0

@onready var snowball: TextureButton = $Control/snowball
@onready var counter: Label = $Control/snowballs_collected/counter
@onready var progress_bar: TextureProgressBar = $Control/snowballs_collected/ProgressBar
@onready var v_box_container: VBoxContainer = $Control/ShopPanel/ShopItemsPanel/VBoxContainer

var regular_size: Vector2
var pressed_size: Vector2

var regular_position: Vector2
var pressed_position: Vector2


func _ready() -> void:
	snowballs_collected = 0
	progress_bar.value = 0
	manual_progress_step = 50
	automatic_progress_step = 0
	regular_position = snowball.position
	pressed_position = snowball.position + Vector2(4, 4)
	regular_size = snowball.size
	pressed_size = snowball.size - Vector2(8, 8)
	update_counter()
	
func _process(delta: float) -> void:
	pass
	
	
func _on_texture_button_button_up() -> void:
	if not EVENTBUS.is_shop_initialised:
		EVENTBUS.init_shop.emit()
	else:
		pass
	snowball.size = regular_size
	snowball.position = regular_position
	progress_bar.value += manual_progress_step
	update_counter()

func update_counter() -> void:
	counter.text = str(snowballs_collected)
	for shop_item in EVENTBUS.shop_items:
		if shop_item.amount_needed > snowballs_collected:
			shop_item.is_active = false
			#print(shop_item.label)
			#print(shop_item.amount_needed)
			#print(snowballs_collected)
			#print("Est actif ? " + str(shop_item.is_active))
		else:
			shop_item.is_active = true
			#print(shop_item.label)
			#print(shop_item.amount_needed)
			#print(snowballs_collected)
			#print("Est actif ? " + str(shop_item.is_active))
		EVENTBUS.check_activation.emit(shop_item.is_active)


func _on_texture_button_button_down() -> void:
	snowball.size = pressed_size
	snowball.position = pressed_position




func _on_progress_bar_value_changed(value: float) -> void:
	if value >= 100:
		progress_bar.value = 0
		snowballs_collected += 1
		update_counter()
		
