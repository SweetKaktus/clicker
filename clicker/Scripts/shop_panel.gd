extends Panel

var hidden_position: Vector2
var displayed_position: Vector2

var is_shop_active: bool



@onready var shop_button: TextureButton = $shop_button
@onready var v_box_container: VBoxContainer = $ShopItemsPanel/VBoxContainer

const SHOP_ELEMENT = preload("res://Scenes/shop_element.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EVENTBUS.is_shop_initialised = false
	EVENTBUS.init_shop.connect(init_shop)
	hidden_position = position
	displayed_position = position - Vector2(0, 350)
	is_shop_active = false
	
	
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_shop_button_pressed() -> void:
	init_shop()
	if not is_shop_active:
		is_shop_active = true
		var tween = create_tween()
		tween.tween_property(self, "position", displayed_position, 0.35)
		tween.tween_callback(tween.kill)
	else:
		is_shop_active = false
		var tween = create_tween()
		tween.tween_property(self, "position", hidden_position, 0.35)
		tween.tween_callback(tween.kill)


func add_element_to_shop(item_name: String, texture: Texture2D, amount_needed: int, amount_bought: int = 0, is_active: bool = false):
	var shop_element = load("res://Scenes/shop_element.tscn")
	var shop_element_instance = shop_element.instantiate()
	v_box_container.add_child(shop_element_instance)
	shop_element_instance.update_item_name(item_name)
	shop_element_instance.update_icon(texture)
	shop_element_instance.update_activation(item_name, is_active)
	shop_element_instance.update_amount_needed(amount_needed)
	shop_element_instance.update_amount_bought(amount_bought)

func init_shop():
	if not EVENTBUS.is_shop_initialised:
		EVENTBUS.is_shop_initialised = true
		for element in EVENTBUS.shop_items:
			add_element_to_shop(element.item_name, 
								element.icon, 
								element.is_active,
								element.amount_needed, 
								element.amount_bought)
	else:
		pass
