extends CharacterBody3D

class_name enemy

@export var main_mesh: MeshInstance3D
@export var max_health: float
@onready var current_heath: float = max_health:
	set (value):
		if value <= 0:
			queue_free()
		else:
			current_heath = value

func set_up_enemy():
	_on_active_item_changed()
	GameManager.active_item_changed.connect(_on_active_item_changed)

func _on_active_item_changed() -> void:
	if GameManager.active_item is RangedWeapon:
		GameManager.active_item.shot.connect(_on_shot)

func _on_shot(target, damage):
	if target == self:
		current_heath -= damage
