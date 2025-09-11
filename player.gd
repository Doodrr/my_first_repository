extends CharacterBody2D

const WALKING_SPEED: float = 170.0
var gravity = 5000.0
const jump_force: float = -5000.0

var jumps_left: int = 2
var jump_timer: float = 0.0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = Vector2.ZERO
	if (Input.is_key_pressed(KEY_S)):
		velocity.y = WALKING_SPEED
	if (Input.is_key_pressed(KEY_A)):
		velocity.x = -WALKING_SPEED
	if (Input.is_key_pressed(KEY_D)):
		velocity.x = WALKING_SPEED
	
	if jump_timer > 0.0: # timer goes down by delta frame rate
		jump_timer -= delta
	
	# Apply gravity
	if not is_on_floor():
		velocity.y += gravity * delta
	else: 
		velocity.y = 0
		jumps_left = 2
	
	# Jump when pressing space
	if (Input.is_key_pressed(KEY_SPACE)) or (Input.is_key_pressed(KEY_W)) and jumps_left > 0 and jump_timer <= 0.0:
		velocity.y = jump_force
		jumps_left -= 1
		jump_timer = 0.2
	
	move_and_slide()
