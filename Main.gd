extends Node

var itemlist:ItemList

func _ready():
	itemlist = $"MC2/VC/ItemList"
	itemlist.select(0)


func is_kinematic_move():
	return itemlist.is_selected(0)


func is_impulse_move():
	return itemlist.is_selected(1)


func _on_Button_pressed():
	get_tree().reload_current_scene()

