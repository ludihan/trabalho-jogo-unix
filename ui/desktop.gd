extends Control

@onready var datetime: Label = $TextureRect/Datetime
const WINDOW = preload("res://ui/FakeWindow.tscn")
const TERMINAL = preload("res://ui/Terminal.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	datetime.text = Time.get_datetime_string_from_system(false, true)


func _on_terminal_app_pressed() -> void:
	var window := WINDOW.instantiate()
	window.add_child(TERMINAL.instantiate())
	add_child(window)
