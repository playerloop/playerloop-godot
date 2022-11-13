class_name PlayerloopSDK
extends Node

const ENVIRONMENT_VARIABLES : String = "playerloop/config"
var request : PlayerloopRequest
var debug: bool = false
var config : Dictionary = { "playerloopSecret": ""}

func _ready() -> void:
	load_config()

# Load all config settings from ProjectSettings
func load_config() -> void:
	if config.playerloopSecret != "":
		load_nodes()
		return
	printerr("Add your secret in the res://addons/Playerloop/playerloop.gd file, line 13")
  
func load_nodes() -> void:
	request = PlayerloopRequest.new()
	request._secret = config["playerloopSecret"]
	add_child(request)

func config(secret:String):
	config["playerloopSecret"] = secret
	load_nodes()

func open_privacy_policy():
	OS.shell_open("https://playerloop.io/privacy-policy")

