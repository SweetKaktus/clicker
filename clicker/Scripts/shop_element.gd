extends HBoxContainer

@onready var check_button: CheckButton = $CheckButton
@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $TextureRect

var shop_items : Array

func _ready() -> void:
	shop_items = EVENTBUS.shop_items
	EVENTBUS.check_activation.connect(update_activation)

func update_check_button(is_checked: bool):
	check_button.button_pressed = is_checked

func update_label_text(text: String):
	label.text = text

func update_texture(texture: Texture2D):
	texture_rect.texture = texture
	
func update_activation(is_active: bool):
	print(label.text + " activation " + str(is_active))
	check_button.disabled = !is_active

func _on_check_button_pressed() -> void:
	var upgrade_name = label.text
	
