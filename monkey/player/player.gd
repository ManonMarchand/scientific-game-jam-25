extends Area2D

@export var speed = 400  # speed (pixel/s)
@export var min_scale: float = 0.65
@export var max_scale: float = 1.
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
	# Clamp up and down
	if position.y <= screen_origin.y:
		position.y = screen_origin.y
	if position.y >= screen_origin.y + screen_size.y:
		position.y = screen_origin.y + screen_size.y
	
	# Clamp left and right
	if position.x <= screen_origin.x:
		position.x = screen_origin.x
	if position.x >= screen_origin.x + screen_size.x:
		position.x = screen_origin.x + screen_size.x
	
	# Compute scale
	var y_prop = (position.y - screen_origin.y) / screen_size.y
	scale = Vector2.ONE * (min_scale + (max_scale - min_scale) * y_prop)
