class_name ParametricVector3

# This class holds 3 expressions for x, y, and z
var expr_x: Expression
var expr_y: Expression
var expr_z: Expression

func _init(expr_str: String):
	var cleaned = expr_str.strip_edges()
	if cleaned.begins_with("(") and cleaned.ends_with(")"):
		cleaned = cleaned.substr(1, cleaned.length() - 2)

	# Split into x, y, z parts
	var parts = cleaned.split(",")

	# Trim and remove whitespace from each part individually
	for i in range(parts.size()):
		parts[i] = parts[i].strip_edges().replace(" ", "")
	
	print(parts)

	# Create expressions
	expr_x = Expression.new()
	expr_y = Expression.new()
	expr_z = Expression.new()

	# Parse expressions with variable 't'
	var err = expr_x.parse(parts[0], ["t"])
	if err != OK:
		print(expr_x.get_error_text())
		return
	err = expr_y.parse(parts[1], ["t"])
	if err != OK:
		print(expr_y.get_error_text())
		return
	err = expr_z.parse(parts[2], ["t"])
	if err != OK:
		print(expr_z.get_error_text())
		return


func evaluate(t: float) -> Vector3:
	var x = expr_x.execute([t])
	if expr_x.has_execute_failed():
		push_error("Failed to evaluate X expression at t = %s" % t)
		x = 0.0

	var y = expr_y.execute([t])
	if expr_y.has_execute_failed():
		push_error("Failed to evaluate Y expression at t = %s" % t)
		y = 0.0

	var z = expr_z.execute([t])
	if expr_z.has_execute_failed():
		push_error("Failed to evaluate Z expression at t = %s" % t)
		z = 0.0

	return Vector3(x, y, z)
