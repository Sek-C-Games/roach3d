extends Node3D

var test_enemy = preload("res://scenes/test_enemy.tscn")

func _on_timer_timeout() -> void:
	var new_enemy = test_enemy.instantiate()
	new_enemy.position = Vector3(randi_range(-10, 10), 10, randi_range(-10, 10))
	add_child(new_enemy)
