extends HBoxContainer

@onready var check_button: CheckButton = $CheckButton
@onready var label: Label = $Label
@onready var texture_rect: TextureRect = $TextureRect



func update_check_button(is_checked: bool):
	check_button.button_pressed = is_checked

func update_label_text(text: String):
	label.text = text

func update_texture(texture_path: String):
	var texture = load(texture_path)
	texture_rect.texture = texture
