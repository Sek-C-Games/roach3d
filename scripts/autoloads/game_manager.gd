extends Node

signal active_item_changed

var active_item: Holdable:
	set(value):
		active_item = value
		active_item_changed.emit()
func _process(delta: float) -> void:
	pass
