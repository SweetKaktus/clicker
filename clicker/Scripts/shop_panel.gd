extends Panel

var hidden_position: Vector2
var displayed_position: Vector2

var is_shop_active: bool


@onready var shop_button: TextureButton = $shop_button
@onready var v_box_container: VBoxContainer = $ShopItemsPanel/VBoxContainer

const SHOP_ELEMENT = preload("res://Scenes/shop_element.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hidden_position = position
	displayed_position = position - Vector2(0, 350)
	is_shop_active = false
	for element in EVENTBUS.shop_items:
		add_element_to_shop(element.label, element.texture, element.amount_needed)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_shop_button_pressed() -> void:
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


func add_element_to_shop(text: String, texture: Texture2D, amount_needed: int):
	var shop_element_instance = SHOP_ELEMENT.instantiate()
	v_box_container.add_child(shop_element_instance)
	shop_element_instance.update_check_button(false)
	shop_element_instance.update_label_text(text)
	shop_element_instance.update_texture(texture)
	print(shop_element_instance.label.text)
