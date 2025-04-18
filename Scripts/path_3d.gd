extends Path3D

const EMILY_PATH = "res://Equations/emilyPart.txt"
const TRISTON_PATH = "res://Equations/tristonPart.txt"
const AIDEN_PATH = "res://Equations/aidenPart.txt"
const SEAN_PATH = "res://Equations/seanPart.txt"
const HENRY_PATH = "res://Equations/henryPart.txt"

var segments: int = 20
var curvingConnectors = CurvingConnectors.new()

var emily_eq
var triston_eq
var aiden_eq
var sean_eq
var henry_eq
var total_lines: int
var total_equations
var filtered_equations: Array[String]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:	
	load_data()
	
	set_equations(emily_eq)
	print("EMILY EQUATION")
	
	make_path(filtered_equations[0], 0, 5)
	print()
	make_path(filtered_equations[1], 5, 15)
	print()
	make_path(filtered_equations[2], 15, 30)
	print()
	make_path(filtered_equations[3], 30, 37)
	print()
	
	make_bezier(curvingConnectors.emily_to_triston)
	print()
	
	set_equations(triston_eq)
	print("TRISTON EQUATION")
	make_path(filtered_equations[0], 10, 5)
	print()
	make_bezier(curvingConnectors.triston1)
	print()
	make_path(filtered_equations[1], 0, 10)
	print()
	make_bezier(curvingConnectors.triston2)
	print()
	make_path(filtered_equations[2], 0, 9)
	print()
	make_bezier(curvingConnectors.triston_to_aiden)
	print()
	
	set_equations(aiden_eq)
	print("AIDEN EQUATION")
	
	make_path(filtered_equations[0], round_to_dec(2 * 3.1415 / 3, 1), round_to_dec(3 * 3.1415, 1))
	print()
	make_path(filtered_equations[1], 0, 1)
	print()
	make_path(filtered_equations[2], -1, 0)
	print()
	make_path(filtered_equations[3], round_to_dec(-6 * 3.1415, 1), 0)
	print()
	make_path(filtered_equations[4], 0, 2)
	print()
	make_path(filtered_equations[5], 2, 5.1)
	print()
	make_path(filtered_equations[6], 0, 1)
	print()
	make_path(filtered_equations[7], 23, 30.6)
	print()
	make_bezier(curvingConnectors.aiden1)
	print()
	make_path(filtered_equations[8], 23, 0.6)
	print()
	make_bezier(curvingConnectors.aiden_to_sean)
	print()
	
	set_equations(sean_eq)
	print("SEAN EQUATION")
	
	make_path(filtered_equations[0], round_to_dec(8 * 3.1415, 1), 0)
	print()
	make_bezier(curvingConnectors.sean1)
	print()
	make_path(filtered_equations[1], -1, round_to_dec(-35 * 3.1415 / 12, 1))
	print()
	make_bezier(curvingConnectors.sean2)
	print()
	make_path(filtered_equations[2], round_to_dec(-3 * 3.1415/2.3, 1), round_to_dec(-3 * 3.1415, 1))
	print()
	make_bezier(curvingConnectors.sean_to_henry)
	print()
	
	set_equations(henry_eq)
	print("HENRY EQUATION")
	make_path(filtered_equations[0], 0, round_to_dec(18 * 3.1415, 1))
	print()
	make_path(filtered_equations[1], -1, 0)
	print()
	make_path(filtered_equations[2], 0, round_to_dec(4 * 3.1415, 1))
	print()
	make_path(filtered_equations[3], 0, round_to_dec(3.1415, 1))
	print()
	make_path(filtered_equations[4], round_to_dec(3.1415, 1), round_to_dec(3.1415 * 2, 1))
	print()
	make_path(filtered_equations[5], round_to_dec(4 * 3.1415, 1), 0)
	print()
	make_bezier(curvingConnectors.henry1)
	print()
	make_path(filtered_equations[6], 0, 5)
	print()
	make_bezier(curvingConnectors.henry2)
	print()
	make_bezier(curvingConnectors.henry3)
	print()
	make_path(filtered_equations[7], round_to_dec(30 * 3.1415, 1), round_to_dec(-3 * 3.1415, 1))
	print()
	segments = 50
	make_bezier(curvingConnectors.henry_to_beginning)
	print()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func load_data():
	if FileAccess.file_exists(EMILY_PATH):
		emily_eq = FileAccess.get_file_as_string(EMILY_PATH)
		
	else:
		print("no data")
	
	if FileAccess.file_exists(TRISTON_PATH):
		triston_eq = FileAccess.get_file_as_string(TRISTON_PATH)
		
	else:
		print("no data")
	
	if FileAccess.file_exists(AIDEN_PATH):
		aiden_eq = FileAccess.get_file_as_string(AIDEN_PATH)
		
	else:
		print("no data")
	
	if FileAccess.file_exists(SEAN_PATH):
		sean_eq = FileAccess.get_file_as_string(SEAN_PATH)
		
	else:
		print("no data")
	
	if FileAccess.file_exists(HENRY_PATH):
		henry_eq = FileAccess.get_file_as_string(HENRY_PATH)
		
	else:
		print("no data")
	
func make_path(convered : String, time_start: float, time_end: float):
	var param_vec = ParametricVector3.new(convered)
	var i : float = time_start
	var increiment = 0.01
	if (time_start < time_end):
		while (i < time_end + increiment):
			var pos = param_vec.evaluate(i)
			#if (i == round_to_dec(i, 1)):
			if (i == time_start || i == time_end):
				print("t = ", i, " → ", desmos_to_godot(pos))
			curve.add_point(desmos_to_godot(pos))
			i = round_to_dec(i + increiment, 2)
			
		print()
		
	elif (time_start > time_end):
		while (i > time_end - increiment):
			var pos = param_vec.evaluate(i)
			#if (i == round_to_dec(i, 1)):
			if (i == time_start || i == time_end):
				print("t = ", i, " → ", desmos_to_godot(pos))
			curve.add_point(desmos_to_godot(pos))
			i = round_to_dec(i - increiment, 2)
			
		print()

func set_equations(file_name):
	filtered_equations.clear()
	total_equations = file_name.split("\n")
	
	for eq in total_equations:
		if !(eq == ""):
			filtered_equations.append(eq)

func make_bezier(points: Array[Vector3]):
	for i in range(segments + 1):
		var t = i / float(segments)
		var point = bezier(t, desmos_to_godot(points[0]), desmos_to_godot(points[1]), desmos_to_godot(points[2]), desmos_to_godot(points[3]))
		print("Bez at ", i, " → ", point)
		curve.add_point(point)

func round_to_dec(num, digit):
	return round(num * pow(10.0, digit)) / pow(10.0, digit)

func desmos_to_godot(eq : Vector3) -> Vector3:
	return Vector3(eq.x, eq.z, eq.y)

func bezier(t: float, p0: Vector3, p1: Vector3, p2: Vector3, p3: Vector3) -> Vector3:
	var u = 1 - t
	return u*u*u*p0 + 3*u*u*t*p1 + 3*u*t*t*p2 + t*t*t*p3
