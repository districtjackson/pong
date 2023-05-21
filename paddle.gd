extends StaticBody2D

@export var left_side: bool = false # determines if the instanced paddle is left or right side
@export var speed = 500
@export var paddle_length = 200
var screen_size
var singleplayer = false
var ball = self
var ai_target # Value that the AI controlled paddle is aiming for at any given time
var higher = false # If the paddle has a higher y value than ai_target at time of generation, used so

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(false)
	screen_size = get_viewport_rect().size
	ai_target = screen_size.y
	paddle_length /= 2 # Halves paddle's length for use in properly offseting clamp

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # Paddle's movement vector
	
	if(!singleplayer):
		if(left_side):                                       # If left paddle (as set in inspector) use W/S
			if(Input.is_action_pressed("left_up")):
				velocity.y -= 1
			if(Input.is_action_pressed("left_down")):
				velocity.y += 1
		else:                                                # If right paddle in multiplayer, use Up/Down arrows
			if(Input.is_action_pressed("right_up")):
				velocity.y -= 1
			if(Input.is_action_pressed("right_down")):
				velocity.y += 1
				
		position += velocity * delta * speed
		position.y = clamp(position.y, 0 + paddle_length, screen_size.y - paddle_length)
	else:                                                     # If right paddle in singleplayer, "AI" controls it
		if(higher and position.y < ai_target): # Make a variable on which should 
			position += Vector2(0, -1) * delta * speed
		elif(!higher and position.y > ai_target):
			position += Vector2(0, 1) * delta * speed
		else:
			ai_target = clamp(ball.position.y + randi_range(-200, 200), 0 + paddle_length, screen_size.y - paddle_length)
			if(position.y > ai_target):
				higher = true
			else:
				higher = false

	

