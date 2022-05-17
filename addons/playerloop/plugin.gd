tool
extends EditorPlugin


func _enter_tree():
	add_autoload_singleton("Playerloop", "res://addons/playerloop/Playerloop/playerloop.gd")


func _exit_tree():
	remove_autoload_singleton("Playerloop")
