extends ParallaxBackground

# Find variables in scene
@onready var player = $'../../Player'
@onready var texture1 = $'TextureRect'
@onready var texture2 = $'TextureRect2'

# Movement speed of texture one (moves in opposition to player)
const TEXT1_MOVEMENT = -0.1
# Movements speed of texture two (moves in opposition to player)
const TEXT2_MOVEMENT = -0.2

func _process(_delta: float) -> void:
	""" 
	Updates position of background images to simulate paralax motion.
	"""
	texture1.position = player.position*TEXT1_MOVEMENT
	texture2.position = player.position*TEXT2_MOVEMENT
