extends TextureButton

signal toggle_fullscreen(fullscreen)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_visible()


func _unhandled_input(event):
	if event.is_action_pressed("ui_fullscreen"):
		OS.window_fullscreen =! OS.window_fullscreen
		update_visible()
	
	
func update_visible():
	visible =! OS.window_fullscreen


func _on_Fullscreen_pressed():
	OS.window_fullscreen = true
	update_visible()
	emit_signal("toggle_fullscreen", true)
	
