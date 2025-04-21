extends Holdable

class_name RangedWeapon

signal shot(target, damage)

@export var damage: float
@export var bullet_emmision_point: Node3D
@export var bullets: PackedScene
@export var col_ray: RayCast3D

func shoot():
	if animation_player.is_playing():
		animation_player.stop()
	var new_bullets:bullet = bullets.instantiate()
	new_bullets.position = bullet_emmision_point.position
	add_child(new_bullets)
	new_bullets.emitting = true
	if col_ray.is_colliding():
		if col_ray.get_collider() is enemy:
			shot.emit(col_ray.get_collider(), damage)
	animation_player.play(use_animation)
