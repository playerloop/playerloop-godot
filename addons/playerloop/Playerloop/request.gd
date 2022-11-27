class_name PlayerloopRequest
extends Node

# Signals
signal completed
signal error

# The HTTP headers used for communicating to playerloop.io
var _headers : PoolStringArray = [
	"Content-Type: application/json",
	"Accept: application/json"
]
# Your project secret
var _secret : String
# The HTTPRequest used for making requests to playerloop.io
var _handler : HTTPRequest = null
# The HTTP response data
var response_report_id : String = ""
# Attachments
var requested_attachments : PoolStringArray = []
# The playerloop.io API URL
var api_url = "https://api.playerloop.io"

# Creates a new bugreport in your project
func post(bug_report_text : String, attachments : PoolStringArray = []) -> void:
	requested_attachments = attachments
	# Create new HTTPRequest
	var http_request = HTTPRequest.new()
	add_child(http_request)
	http_request.connect("request_completed", self, "_http_request_completed")
	# Add "Authorization" header
	_headers.append("Authorization: %s"%[_secret])
	# Create HTTP request body
	var body : Dictionary = {
		"text": bug_report_text,
		"type": "bug",
		"accepted_privacy" : true,
		"client" : "godot",
		"player" : {
			"id" : OS.get_unique_id()
		}
	}
	# Makes the API request to playerloop.io and saves the output into "error"
	var error = http_request.request(api_url + "/reports", _headers, false, HTTPClient.METHOD_POST, JSON.print(body))
	# Checks if the request was successfully sent
	if error != OK:
		push_error("Failed creating bugreport: A HTTP error was encountered")
		return

# Called when the HTTP request is completed.
func _http_request_completed(result, response_code, headers, body):
	# Check against API error
	if response_code > 300:
		push_error("Failed creating bugreport: The API responded with a response code of " + str(response_code))
	# Upload attachments
	if requested_attachments.size() > 0:
		# Parse HTTP body as JSON
		var response = JSON.parse(body.get_string_from_utf8())
		if response.error != OK:
			push_error("Failed uploading attachment: HTTP body could not be parsed as JSON")
			return
		# Saves the report ID
		if response.result["data"] == null:
			push_error("Failed uploading attachment: data is null")
			return
		if response.result["data"]["id"] == null or response.result["data"]["id"] == "":
			push_error("Failed uploading attachment: Report ID is null")
			return
		response_report_id = response.result["data"]["id"]
		for attachment in requested_attachments:
			upload_attachment(response_report_id, attachment)
	else:
		_report_sent_successfully()

# Uploads attachments to a report
func upload_attachment(report_id : String, file_path : String) -> void:
	# The HTTP headers used for making the request
	var upload_headers : PoolStringArray = [
		#"Content-Disposition: form-data",
		"Content-Type: multipart/form-data; boundary=\"WebKitFormBoundaryePkpFF7tjBAqx29L\"",
		"Authorization: "+_secret,
		#"filename: test.txt",
		#"name: file"
	]
	# Reading the attachment file
	var file = File.new()
	file.open(file_path, File.READ)
	var file_content = file.get_buffer(file.get_len())
	# Creates the HTTP body
	var body_a = PoolByteArray()
	body_a.append_array("\r\n--WebKitFormBoundaryePkpFF7tjBAqx29L\r\n".to_utf8())
	var fileComplete : String = "Content-Disposition: form-data; name=\"file\"; filename=\"" + file_path.get_file()+"\"\r\n"
	body_a.append_array(fileComplete.to_utf8())
	body_a.append_array("Content-Type: application/octet-stream\r\n\r\n".to_utf8())
	body_a.append_array(file_content)
	body_a.append_array("\r\n--WebKitFormBoundaryePkpFF7tjBAqx29L--\r\n".to_utf8())
	
	# Creates a new HTTPClient that connects to the playerloop.io API
	var http = HTTPClient.new()

	http.connect_to_host(api_url, 443, false)

	while http.get_status() == HTTPClient.STATUS_CONNECTING or http.get_status() == HTTPClient.STATUS_RESOLVING:
		http.poll()
		OS.delay_msec(10)
	
	# Sends the HTTP request and saves it's output as "err"
	var err = http.request_raw(HTTPClient.METHOD_POST, "/reports/" + report_id + "/attachments", upload_headers, body_a)
	
	# Checks for errors
	if err != OK:
		printerr("Failed uploading attachments: A HTTP error has been encountered")
	
	var _reading_body = false
	var _response_headers : PoolStringArray
	var _response_data : PoolByteArray
	var _content_length : int
	var _response_code : int
	
	# Recieve status update
	while http.get_status() != HTTPClient.STATUS_BODY:
		http.poll()
		OS.delay_msec(10)
	
	# Processes status updates
	while http.get_status() == HTTPClient.STATUS_BODY:
		match http.get_status():
			HTTPClient.STATUS_DISCONNECTED:
				# API disconnected or network failure, throw error
				emit_signal("error")
			
			# Recieve status update
			HTTPClient.STATUS_RESOLVING, HTTPClient.STATUS_REQUESTING, HTTPClient.STATUS_CONNECTING:
				http.poll()
			
			# Process body
			HTTPClient.STATUS_BODY:
				if http.has_response() or _reading_body:
					_reading_body = true
					
					# If there is a response...
					if _response_headers.empty():
						# Get response headers.
						_response_headers = http.get_response_headers()
						_response_code = http.get_response_code()
						
						for header in _response_headers:
							if "Content-Length" in header:
								_content_length = header.trim_prefix("Content-Length: ").to_int()
								print(_content_length)
					
					http.poll()
					# Get a chunk.
					var chunk : PoolByteArray = http.read_response_body_chunk()
					if chunk.size() == 0:
						# Got nothing, wait for buffers to fill a bit.
						pass
						OS.delay_msec(10)
					else:
						# Append to read buffer
						_response_data += chunk
						if _content_length != 0:
							pass
						OS.delay_msec(10)
						_upload_completed(0, _response_code, _response_headers, _response_data)
				else:
					OS.delay_msec(10)
	

# Completes a attachment upload
func _upload_completed(result, response_code, headers, body):
	# Check against API error
	if response_code > 300:
		push_error("Failed creating bugreport: The API responded with a response code of " + str(response_code))
		return
	# Prints the user agent string used by the HTTPRequest node (as recognized by httpbin.org).
	_report_sent_successfully()

# Marks the API request as successful
func _report_sent_successfully():
	emit_signal("completed")
