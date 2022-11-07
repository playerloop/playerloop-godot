tool
extends Control

func _ready() -> void:
	Playerloop.request.post("test dock")
	print("hey")

func _on_Submit_pressed() -> void:
	Playerloop.config["playerloopSecret"] = $Label.text
