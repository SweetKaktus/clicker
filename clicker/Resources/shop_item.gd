class_name ShopItem
extends Resource

var item_name : String
var icon : Texture2D
var is_active : bool
var amount_needed : int
var amount_bought : int

func initialiser(_item_name: String, 
				 _icon: Texture2D, 
				 _amount_needed: int, 
				 _amount_bought: int = 0, 
				 _is_active: bool = false):
	item_name = _item_name
	icon = _icon
	amount_needed = _amount_needed
	is_active = _is_active
	amount_bought = 0
