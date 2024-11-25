extends Control

@onready var datetime: Label = $TextureRect/Datetime
const WINDOW = preload("res://ui/Window.tscn")
const TERMINAL = preload("res://ui/Terminal.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	datetime.text = Time.get_datetime_string_from_system(false, true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	datetime.text = Time.get_datetime_string_from_system(false, true)


func _on_texture_button_pressed() -> void:
	get_tree().root.add_child(WINDOW.instantiate())
