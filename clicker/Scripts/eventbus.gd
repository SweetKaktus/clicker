extends Node

var seconde_main : ShopItem
var lutin_exploite : ShopItem
var union_fait_force : ShopItem
var usine : ShopItem

var seconde_main_icon = preload("res://Assets/gui/beer-stein.svg")
var lutin_exploite_icon = preload("res://Assets/gui/caveman.svg")
var union_fait_force_icon = preload("res://Assets/gui/waterskin.svg")
var usine_icon = preload("res://Assets/gui/hut.svg")

var shop_items: Array

var is_shop_initialised: bool = false

signal check_activation(item_name: String, is_active : bool)
signal init_shop

var icons_for_check_box = {
	"Unchecked" : "res://Assets/gui/Butto.png",
	"Uncheckd_presssed" : "res://Assets/gui/Butto-pressed.png",
	"Checked" : "res://Assets/gui/Buttons-v.png",
	"Checked_pressed" : "res://Assets/gui/Buttons-pressed-v.png"
}


func _ready() -> void:
	seconde_main = ShopItem.new()
	lutin_exploite = ShopItem.new()
	union_fait_force = ShopItem.new()
	usine = ShopItem.new()
	seconde_main.initialiser("Seconde main", seconde_main_icon, 2)
	lutin_exploite.initialiser("Lutin exploité", lutin_exploite_icon, 2)
	union_fait_force.initialiser("L'union fait la force", union_fait_force_icon, 5)
	usine.initialiser("Usine", usine_icon, 10)
	shop_items = [
		seconde_main,
		lutin_exploite,
		union_fait_force,
		usine
	]
