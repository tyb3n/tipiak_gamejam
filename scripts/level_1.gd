extends Node2D

var node_light
var node_player
var start_pos
# Called when the node enters the scene tree for the first time.
func _ready():
	node_player = get_node("player")
	start_pos = node_player.position
	node_light = get_node("player/PointLight2D")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var light_size = get_node("Timer").time_left/1.2
	node_light.scale = Vector2(1,1) * light_size


func _on_timer_timeout():
	node_player.position = start_pos
