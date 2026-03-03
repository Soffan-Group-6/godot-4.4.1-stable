# https://github.com/godotengine/godot/issues/107588
# Exported Dictionary and Array properties on Resource subclasses must be
# independent across instances. This is the exact scenario from the upstream
# bug report where multiple .tres files with empty exported dictionaries
# ended up pointing to the same object in memory.

class TestResource:
	extends Resource
	@export var data: Dictionary = {}
	@export var items: Array = []
	@export var typed_data: Dictionary[String, int] = {}
	@export var typed_items: Array[String] = []

func test():
	var res_a := TestResource.new()
	var res_b := TestResource.new()
	var res_c := TestResource.new()

	# Add data to only res_a.
	res_a.data["player"] = "Alice"
	res_a.items.push_back("sword")
	res_a.typed_data["score"] = 100
	res_a.typed_items.push_back("shield")

	# res_b and res_c must be unaffected.
	print("res_a.data: ", res_a.data)
	print("res_b.data: ", res_b.data)
	print("res_c.data: ", res_c.data)

	print("res_a.items: ", res_a.items)
	print("res_b.items: ", res_b.items)
	print("res_c.items: ", res_c.items)

	print("res_a.typed_data: ", res_a.typed_data)
	print("res_b.typed_data: ", res_b.typed_data)
	print("res_c.typed_data: ", res_c.typed_data)

	print("res_a.typed_items: ", res_a.typed_items)
	print("res_b.typed_items: ", res_b.typed_items)
	print("res_c.typed_items: ", res_c.typed_items)

	# Now modify res_b and verify res_a and res_c are independent.
	res_b.data["enemy"] = "Bob"
	print("res_a.data size: ", res_a.data.size())
	print("res_b.data size: ", res_b.data.size())
	print("res_c.data size: ", res_c.data.size())
