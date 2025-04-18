extends PathFollow3D

@export var speed: float = 25
@export var offset_above_path: float = 1.0 # Distance above the path

func _process(delta: float) -> void:
	progress += speed * delta

	# Get the up direction of the path
	var up_dir = transform.basis.y.normalized()

	# Move the camera above the path along the up direction
	var cam = $Camera3D
	cam.global_transform.origin = global_transform.origin + up_dir * offset_above_path

	# Make the camera look forward along the path
	#var forward = -transform.basis.z.normalized()
	#cam.look_at(cam.global_transform.origin + forward, up_dir)
