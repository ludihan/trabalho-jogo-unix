extends Control

func _on_texture_button_pressed() -> void:
	queue_free()

# Tracks if the window is being dragged
var is_dragging: bool = false
var drag_offset: Vector2
# obrigado gpt
func _on_bar_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# Start dragging on left mouse button press
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			is_dragging = true
			drag_offset = event.position
		elif event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			is_dragging = false
	elif event is InputEventMouseMotion and is_dragging:
		# Dragging logic
		position += event.relative
