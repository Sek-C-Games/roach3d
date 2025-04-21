extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
var edelta: float

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * Global.sensitivity))
		$Camera.rotate_x(deg_to_rad(-event.relative.y * Global.sensitivity))
		$Camera.rotation.x = clamp($Camera.rotation.x, -1.57, 0.8)
func _process(delta: float) -> void:
	edelta = delta
	if Input.is_action_just_pressed("test_button"):
		add_shotgun()
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func add_shotgun() -> void:
	if GameManager.active_item:
		GameManager.active_item.queue_free()
	var preshotgun = preload("res://scenes/weapons/shotgun.tscn")
	var new_shotgun = preshotgun.instantiate()
	$Camera/gun_point.add_child(new_shotgun)
	GameManager.active_item = new_shotgun
