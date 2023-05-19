extends StaticBody2D

@export var left_side: bool = false
@export var speed = 500
@export var paddle_length = 200
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	paddle_length /= 2 # Halves paddle's length for use in properly offseting clamp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # Paddle's movement vector
	
	if(left_side): # If on the left side (as set in inspector) use W/S
		if(Input.is_action_pressed("left_up")):
			velocity.y -= 1
		if(Input.is_action_pressed("left_down")):
			velocity.y += 1
	else:          # If on the right side, use Up/Down arrows
		if(Input.is_action_pressed("right_up")):
			velocity.y -= 1
		if(Input.is_action_pressed("right_down")):
			velocity.y += 1

	position += velocity * delta * speed
	position.y = clamp(position.y, 0 + paddle_length, screen_size.y - paddle_length)
	

