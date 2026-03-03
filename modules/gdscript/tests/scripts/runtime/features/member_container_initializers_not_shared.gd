# https://github.com/godotengine/godot/issues/107588
# Dictionary and Array member initializers with constant values must not be
# shared across instances. Constant containers are reduced at compile time
# and must not leak the same reference to multiple instances.

class WithDefaults:
	extends RefCounted
	var dict_with_data: Dictionary = {"a": 1, "b": 2}
	var array_with_data: Array = [10, 20, 30]

func test():
	var a := WithDefaults.new()
	var b := WithDefaults.new()

	# Verify initial values are correct.
	print("a.dict_with_data: ", a.dict_with_data)
	print("b.dict_with_data: ", b.dict_with_data)
	print("a.array_with_data: ", a.array_with_data)
	print("b.array_with_data: ", b.array_with_data)

	# Modify one instance's containers.
	a.dict_with_data["c"] = 3
	a.array_with_data.push_back(40)

	# The other instance must be unaffected.
	print("a.dict_with_data size: ", a.dict_with_data.size())
	print("b.dict_with_data size: ", b.dict_with_data.size())
	print("a.array_with_data size: ", a.array_with_data.size())
	print("b.array_with_data size: ", b.array_with_data.size())

	# Clear one instance's containers; the other must be unaffected.
	a.dict_with_data.clear()
	a.array_with_data.clear()
	print("a.dict_with_data size after clear: ", a.dict_with_data.size())
	print("b.dict_with_data size after clear: ", b.dict_with_data.size())
	print("a.array_with_data size after clear: ", a.array_with_data.size())
	print("b.array_with_data size after clear: ", b.array_with_data.size())
