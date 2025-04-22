extends enemy

func _ready() -> void:
	set_up_enemy()
	var new_material: StandardMaterial3D = StandardMaterial3D.new()
	new_material.albedo_color = Color(randf(), randf(), randf())
	main_mesh.mesh.material = new_material

func _process(delta: float) -> void:
	velocity += get_gravity() * delta
	move_and_slide()
