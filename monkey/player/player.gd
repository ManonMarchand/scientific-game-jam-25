extends Area2D

@export var speed = 350  # speed (pixel/s)
var screen_origin: Vector2
var screen_size: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_origin = Vector2.ZERO
	screen_size = get_viewport_rect().size

func set_screen(origin: Vector2, size: Vector2) -> void:
	screen_origin = origin
	screen_size = size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	# Get real velocity
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		# $AnimatedSprite2D.play()
	#else:
	#	$AnimatedSprite2D.stop()
	
	position += velocity * delta
	position = position.clamp(screen_origin, screen_size)
