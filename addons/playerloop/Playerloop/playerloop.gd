class_name PlayerloopSDK
extends Node

var request : PlayerloopRequest

var debug: bool = false

var secret:String = "your_project_secret_here"

func _ready() -> void:
	load_config()
	load_nodes()

# Load all config settings from config.gd
func load_config() -> void:
	# Checks if config secret is "" or null
	if secret == "" or secret == null:
		printerr("You'll need to add your Playerloop.io project secret into res://addons/playerloop/Playerloop/config.gd (line 3)")
		return

# Adds PlayerloopRequest to script, used for making requests to playerloop.io
func load_nodes() -> void:
	request = PlayerloopRequest.new()
	request._secret = secret
	add_child(request)

# Opens the playerloop.io privacy policy
func open_privacy_policy():
	OS.shell_open("https://playerloop.io/privacy-policy")
