class_name ShopItem
extends Resource

var label : String
var texture : Texture2D
var is_active : bool
var amount_needed : int
var amount_bought : int

func initialiser(_label: String, _texture: Texture2D, _amount_needed: int):
	label = _label
	texture = _texture
	amount_needed = _amount_needed
	is_active = false
	amount_bought = 0
