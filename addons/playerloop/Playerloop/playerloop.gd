class_name PlayerloopSDK
extends Node

const ENVIRONMENT_VARIABLES : String = "playerloop/config"

#var report : PlayerloopReport 
var request : PlayerloopRequest

var debug: bool = false

var config : Dictionary = {
	"playerloopSecret": ""
}

func _ready() -> void:
	load_config()
	load_nodes()

# Load all config settings from ProjectSettings
func load_config() -> void:
	if config.playerloopSecret != "":
		pass
	else:
		printerr("Add your secret in the res://addons/Playerloop/playerloop.gd file, line 13")
		return
	# else:   
	# 	var env = ConfigFile.new()
	# 	var err = env.load("res://addons/playerloop/.env")
	# 	if err == OK:
	# 		for key in config.keys(): 
	# 			var value : String = env.get_value(ENVIRONMENT_VARIABLES, key, "")
	# 			if value == "":
	# 				printerr("%s has not a valid value." % key)
	# 			else:
	# 				config[key] = value
	# 	else:
	# 		printerr("Unable to read .env file at path 'res://.env'")

func load_nodes() -> void:
	request = PlayerloopRequest.new()
	request._secret = config["playerloopSecret"]
	add_child(request)

func open_privacy_policy():
	OS.shell_open("https://playerloop.io/privacy-policy")