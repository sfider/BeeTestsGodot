extends Label

@export var cpu: Label
@export var rt_cpu: Label
@export var rt_gpu: Label

var viewport_rid: RID

func _ready():
	viewport_rid = get_tree().root.get_viewport_rid()
	RenderingServer.viewport_set_measure_render_time(viewport_rid, true)

func _process(delta):
	set_text("fps: %.2f" % Performance.get_monitor(Performance.TIME_FPS))
	if cpu != null:
		var cpu_ms = Performance.get_monitor(Performance.TIME_PROCESS) * 1000.0
		cpu.set_text("cpu: %.2fms" % cpu_ms)
	if rt_cpu != null:
		var rt_cpu_ms = RenderingServer.viewport_get_measured_render_time_cpu(viewport_rid)
		rt_cpu.set_text("rt_cpu: %.2fms" % rt_cpu_ms)
	if rt_gpu != null:
		var rt_gpu_ms = RenderingServer.viewport_get_measured_render_time_gpu(viewport_rid)
		rt_gpu.set_text("rt_gpu: %.2fms" % rt_gpu_ms)
	
func _input(event):
	if event.is_action_pressed("2D"):
		get_tree().change_scene_to_file("res://2D/Test2D.tscn")
	if event.is_action_pressed("3D"):
		get_tree().change_scene_to_file("res://3D/Test3D.tscn")
	if event.is_action_pressed("vsync"):
		if DisplayServer.window_get_vsync_mode()==DisplayServer.VSYNC_ENABLED:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		else:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
			
