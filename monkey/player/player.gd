extends Area2D

signal leave_right
signal leave_left

@export var speed = 400  # speed (pixel/s)
@export var min_scale: float = 0.65
@export var max_scale: float = 1.
var screen_origin: Vector2
var screen_size: Vector2

# movement variables
var is_walking = false
var face_right = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_origin = Vector2.ZERO
	screen_size = get_viewport_rect().size
	$AnimatedSprite2D.play("idle")

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
	
	var now_is_walking = false
	var now_face_right = false
	# Get real velocity
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		now_is_walking = true
	else:
		now_is_walking = false
	
	if velocity.x >= 0:
		now_face_right = true
	else:
		now_face_right = false

	# clamp position
	my_clamp(position + velocity * delta)
	
	# Compute scale
	var y_prop = (position.y - screen_origin.y) / screen_size.y
	scale = Vector2.ONE * (min_scale + (max_scale - min_scale) * y_prop)
	
	# Update animation
	if not is_walking and now_is_walking:
		$AnimatedSprite2D.play("walk")
	if is_walking and not now_is_walking:
		$AnimatedSprite2D.play("idle")
	
	is_walking = now_is_walking
	if velocity.x != 0:
		face_right = now_face_right
	if face_right:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false


func my_clamp(new_position: Vector2):
	# Clamp up and down
	if new_position.y + $CollisionShape2D.position.y - $CollisionShape2D.shape.size.y/2 <= screen_origin.y:
		new_position.y = position.y
	if new_position.y + $CollisionShape2D.position.y + $CollisionShape2D.shape.size.y/2 >= screen_origin.y + screen_size.y:
		new_position.y = position.y
	
	# Clamp left and right
	if new_position.x + $CollisionShape2D.position.x - $CollisionShape2D.shape.size.x/2 <= screen_origin.x:
		new_position.x = position.x
		leave_left.emit()
		return
	if new_position.x + $CollisionShape2D.position.x + $CollisionShape2D.shape.size.x/2 >= screen_origin.x + screen_size.x:
		new_position.x = position.x
		leave_right.emit()
		return
	position = new_position
