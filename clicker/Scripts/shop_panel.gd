extends Panel

var hidden_position: Vector2
var displayed_position: Vector2

var is_shop_active: bool


@onready var shop_button: TextureButton = $shop_button



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hidden_position = position
	displayed_position = position - Vector2(0, 350)
	is_shop_active = false
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	


func _on_shop_button_pressed() -> void:
	if not is_shop_active:
		is_shop_active = true
		var tween = create_tween()
		tween.tween_property(self, "position", displayed_position, 0.35)
	else:
		is_shop_active = false
		var tween = create_tween()
		tween.tween_property(self, "position", hidden_position, 0.35)
