extends ParallaxBackground

@onready var player = $'../../Player'
@onready var texture1 = $'TextureRect'
@onready var texture2 = $'TextureRect2'

const TEXT1_MOVEMENT = -0.1
const TEXT2_MOVEMENT = -0.2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	texture1.position = player.position*TEXT1_MOVEMENT
	texture2.position = player.position*TEXT2_MOVEMENT
