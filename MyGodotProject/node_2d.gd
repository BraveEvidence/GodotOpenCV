extends Node2D

var _plugin_name = "MyPlugin"
var _android_plugin

@onready var texturerect = $TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if Engine.has_singleton(_plugin_name):
		_android_plugin = Engine.get_singleton(_plugin_name)
		_android_plugin.connect("testSignal",_on_testSignal)
	else:
		printerr("Couldn't find plugin " + _plugin_name)
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	if _android_plugin:
		_android_plugin.convertImageToGrayScale()
		
func _on_testSignal(data):
	var img = Image.new()
	img.load_jpg_from_buffer(Marshalls.base64_to_raw(str(data)))
	texturerect.texture = ImageTexture.create_from_image(img)
