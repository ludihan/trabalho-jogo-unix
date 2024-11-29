extends Control

@onready var bar: ColorRect = $VBoxContainer/HBoxContainer/Bar
@onready var close: TextureButton = $VBoxContainer/HBoxContainer/Close

signal clicked

# Tracks if the window is being dragged
var is_dragging: bool = false
var drag_offset: Vector2

func _ready() -> void:
	bar.mouse_filter = MouseFilter.MOUSE_FILTER_PASS
	close.mouse_filter = MouseFilter.MOUSE_FILTER_PASS


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


func _on_close_pressed() -> void:
	queue_free()
