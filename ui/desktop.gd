extends Control


const WINDOW = preload("res://ui/fake_window.tscn")
const TERMINAL = preload("res://ui/terminal.tscn")
const MANUAL = preload("res://ui/manual.tscn")
const LEVEL = preload("res://ui/level.tscn")
const SHOP = preload("res://ui/shop.tscn")

@onready var desktop_area: Control = $DesktopArea
@onready var datetime: Label = $HBoxContainer/Datetime
@onready var tutorial_label: Label = $TutorialLabel

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	datetime.text = Time.get_datetime_string_from_system(false, true)


func instatentiate_window(resource: PackedScene) -> void:
	var window := WINDOW.instantiate()
	var thing := resource.instantiate()
	window.get_node("VBoxContainer/Content").add_child(thing)
	thing.mouse_filter = MouseFilter.MOUSE_FILTER_PASS
	window.got_focus.connect(func(): desktop_area.move_child(window, desktop_area.get_child_count() - 1))

	desktop_area.add_child(window)
	thing.grab_focus()


func _on_terminal_app_pressed() -> void:
	instatentiate_window(TERMINAL)


func _on_man_button_pressed() -> void:
	if tutorial_label != null:
		tutorial_label.queue_free()
	instatentiate_window(MANUAL)


func _on_turn_off_button_pressed() -> void:
	get_tree().quit()


func _on_level_1_app_pressed() -> void:
	instatentiate_window(LEVEL)


func _on_shop_app_pressed() -> void:
	instatentiate_window(SHOP)
