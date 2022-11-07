tool
extends Control

func _on_Submit_pressed() -> void:
	Playerloop.config["playerloopSecret"] = $Label.text
