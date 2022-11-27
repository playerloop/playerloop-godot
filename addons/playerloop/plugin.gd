tool
extends EditorPlugin

# Add autoload singleton when enabling plugin
func _enter_tree():
	add_autoload_singleton("Playerloop", "res://addons/playerloop/Playerloop/playerloop.gd")

# Remove autoload singleton when disabling plugin
func _exit_tree():
	remove_autoload_singleton("Playerloop")
