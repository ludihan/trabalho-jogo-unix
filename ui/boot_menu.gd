extends VBoxContainer

@onready var start_label: Label = $StartLabel
@onready var options_label: Label = $OptionsLabel
@onready var exit_label: Label = $ExitLabel
@onready var BLACK_LABEL := LabelSettings.new()
@onready var WHITE_LABEL := LabelSettings.new()

enum STATE {
	START,
	OPTIONS,
	EXIT,
}

var current_state := 0
var states := [STATE.START, STATE.OPTIONS, STATE.EXIT]

func _ready() -> void:
	BLACK_LABEL.font_color = Color.BLACK
	WHITE_LABEL.font_color = Color.WHITE
	update_labels(states[current_state])

func _input(event: InputEvent) -> void:
	var states := [STATE.START, STATE.OPTIONS, STATE.EXIT]
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_DOWN:
				if current_state != len(states) - 1:
					current_state = (current_state + 1) % 3
			KEY_UP:
				if current_state != 0:
					current_state = (current_state - 1 + len(states)) % 3
	print(current_state)
	update_labels(states[current_state])

func update_labels(state: STATE):
	start_label.label_settings = WHITE_LABEL
	options_label.label_settings = WHITE_LABEL
	exit_label.label_settings = WHITE_LABEL
	match state:
		STATE.START:
			start_label.label_settings = BLACK_LABEL
		STATE.OPTIONS:
			options_label.label_settings = BLACK_LABEL
		STATE.EXIT:
			exit_label.label_settings = BLACK_LABEL
