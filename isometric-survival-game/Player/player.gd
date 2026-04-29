extends CharacterBody2D

var input_direction : Vector2
var speed : float = 150
var movement_state_multiplier : float = 1

var idle : bool = true
var walking : bool = false
var sprinting : bool = false
var punching : bool = false

# Animation Variables
var currentAnimation : AnimatedSprite2D
@export var faceFront : AnimatedSprite2D
@export var faceFrontRight : AnimatedSprite2D
@export var faceFrontLeft : AnimatedSprite2D
@export var faceRight : AnimatedSprite2D
@export var faceLeft : AnimatedSprite2D
@export var faceBack : AnimatedSprite2D
@export var faceBackLeft : AnimatedSprite2D
@export var faceBackRight : AnimatedSprite2D

var directions : Array = []
var animationDirection : AnimatedSprite2D

@export var inventory: inv

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	directions = [faceRight,
	faceFrontRight,
	faceFront,
	faceFrontLeft,
	faceLeft,
	faceBackLeft,
	faceBack,
	faceBackRight]
	
	animationDirection = faceFront
	currentAnimation = faceFront
	currentAnimation.visible = true

func isometric_to_cartesian(cartesian: Vector2) -> Vector2:
	return Vector2(cartesian.x - cartesian.y, (cartesian.x + cartesian.y) / 2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# get input
	input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	# rotate input
	var rotated_input = input_direction.rotated(-(PI / 4))
	# clean input
	var clean_input = rotated_input.limit_length(1.0)
	
	if Input.is_action_just_pressed("Sprint"):
		sprinting = true
		movement_state_multiplier = 1.5
	elif Input.is_action_just_released("Sprint"):
		sprinting = false
		movement_state_multiplier = 1

	# check if moving
	if input_direction != Vector2.ZERO:
		idle = false
		
		# physics logic
		velocity = isometric_to_cartesian(clean_input) * speed * movement_state_multiplier
		
		# animation logic
		animationDirection = directions[get_directions(velocity)]
		currentAnimation.visible = false
		currentAnimation = animationDirection
		currentAnimation.visible = true
		movement_check(velocity)
		currentAnimation.play(animation_check())
	else:
		# physics logic
		velocity = Vector2.ZERO
		# animation logic
		idle = true
		currentAnimation.play(animation_check())
	move_and_slide()

# retrieve the direction the player is facing out of the 8 isometric movement directions
func get_directions(velocity):
	var angle = velocity.angle()
	var direction_index = wrapi(round(angle / (PI/4)), 0, 8)
	return direction_index

# check if walking or sprinting
func movement_check(velocity):
	if velocity != Vector2.ZERO:
		if sprinting == true:
			walking = false
		elif sprinting == false and idle != true:
			walking = true
		return walking

# check which animation to use
func animation_check():
	if sprinting == true:
		return "Run"
	elif idle == true:
		return "Idle"
	elif walking == true:
		return "Walk"

func collect(item):
	inventory.insert(item)
