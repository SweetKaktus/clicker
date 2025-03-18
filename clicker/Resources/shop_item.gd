class_name ShopItem
extends Resource

'''
Ce script me permet de créer un objet "ShopItem" qui vient contenir différents
types de données me permettant de gérer les items du shop ensuite.

L'objet "res://Resources/shop_item.tres" se sert de ce script pour fonctionner
'''

# Correspond au nom de l'item
var item_name : String
# Correspond à l'icône de l'item
var icon : Texture2D
# Vérifie si l'item est grisé ou non
var is_active : bool
# Prix d'achat de l'item
var amount_needed : int
# Nombre d'occurrences de l'item détenues
var amount_bought : int

# Fonction permettant d'initialiser toutes les données détenues par l'item
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
