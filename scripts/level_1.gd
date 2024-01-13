extends Node2D

var node_light
var node_player
var node_camera
var start_pos
var node_timer
# Called when the node enters the scene tree for the first time.
func _ready():
	node_player = get_node("player")
	node_camera = get_node("player/Camera2D")
	node_timer = get_node("Timer")
	start_pos = node_player.position
	node_light = get_node("player/PointLight2D")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	/* if player is moving, camera zoom = 0.6 with smooth transition
#	if player not moving, camera_zoom = 0.4 with smooth transition
	if node_player.velocity :
		if node_camera.zoom.x < 0.6 :
			node_camera.zoom += Vector2(.01,.01)
	else :
		if node_camera.zoom.x > 0.4 :
			node_camera.zoom -= Vector2(0.01,.01)
	var light_size
	if !node_timer.is_stopped() :
		light_size = node_timer.time_left/1.2
	else : 
		light_size = node_timer.wait_time/1.2
	node_light.scale = Vector2(1,1) * light_size


func _on_timer_timeout():
	node_player.position = start_pos

func _on_camp_fire_body_entered(_body):
	print("area_entered")
	node_timer.start()
	node_timer.stop()


func _on_camp_fire_body_exited(body):
	node_timer.start()
