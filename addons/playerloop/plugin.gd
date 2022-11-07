tool
extends EditorPlugin

var interface = preload("res://addons/playerloop/SettingInterface.tscn").instance()

func _enter_tree():
	add_autoload_singleton("Playerloop", "res://addons/playerloop/Playerloop/playerloop.gd")
	add_control_to_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT, interface)


func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_PROJECT_SETTING_TAB_RIGHT, interface)
	remove_autoload_singleton("Playerloop")
