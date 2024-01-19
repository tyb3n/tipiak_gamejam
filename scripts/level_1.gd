extends Node2D

var node_light
var node_player
var node_camera
var start_pos
var node_timer
var node_halo
var level_started = false
@export var offset = Vector2(32,25)
@export var zoom_speed = float(0.003)
#@onready var screensize = get_viewport().size.x 
# Called when the node enters the scene tree for the first time.
func _ready():
	node_player = get_node("player")
	node_camera = get_node("player/Camera2D")
	node_timer = get_node("Timer")
	node_halo = get_node("BackBufferCopy/halo")
	start_pos = node_player.position
	# Lets us keep the all-consuming darkness disabled in the editor
	get_node("BackBufferCopy").show()




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
#	/* if player is moving, camera zoom = 0.6 with smooth transition
#	if player not moving, camera_zoom = 0.4 with smooth transition
	_zoom()
	var light_size
	if node_player.velocity.x and !level_started:
		node_timer.start()
		level_started = true
	
	if !node_timer.is_stopped() :
		light_size = node_timer.time_left/1.2
	else : 
		light_size = node_timer.wait_time/1.2
	node_halo.scale = Vector2(1,1) * light_size
	node_halo.position = node_player.position + offset

func _zoom():
	if node_player.velocity and !node_timer.is_stopped() :
		if node_camera.zoom.x < 0.6 :
			node_camera.zoom += Vector2(zoom_speed,zoom_speed)
	else :
		if node_camera.zoom.x > 0.4 :
			node_camera.zoom -= Vector2(zoom_speed,zoom_speed)

func _on_timer_timeout():
	node_player.position = start_pos
	level_started = false

func _on_camp_fire_body_entered(_body):
	print("area_entered")
	get_node("BackBufferCopy/fire").scale = Vector2(1,1) * node_timer.wait_time/1.2
	node_timer.start()
	node_timer.stop()


func _on_camp_fire_body_exited(_body):
	node_timer.start()
