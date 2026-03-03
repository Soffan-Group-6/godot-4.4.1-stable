# https://github.com/godotengine/godot/issues/107588
# Empty Dictionary and Array member defaults must not be shared across instances.

class MyResource:
	extends RefCounted
	var empty_dict: Dictionary = {}
	var empty_array: Array = []
	var typed_dict: Dictionary[String, int] = {}
	var typed_array: Array[int] = []

func test():
	var a := MyResource.new()
	var b := MyResource.new()

	# Each instance should have independent empty dictionaries.
	a.empty_dict["key"] = "value"
	print("a.empty_dict size: ", a.empty_dict.size())
	print("b.empty_dict size: ", b.empty_dict.size())

	# Each instance should have independent empty arrays.
	a.empty_array.push_back(1)
	print("a.empty_array size: ", a.empty_array.size())
	print("b.empty_array size: ", b.empty_array.size())

	# Each instance should have independent typed dictionaries.
	a.typed_dict["hello"] = 42
	print("a.typed_dict size: ", a.typed_dict.size())
	print("b.typed_dict size: ", b.typed_dict.size())

	# Each instance should have independent typed arrays.
	a.typed_array.push_back(99)
	print("a.typed_array size: ", a.typed_array.size())
	print("b.typed_array size: ", b.typed_array.size())

	# Multiple properties on the same instance should also be independent.
	var c := MyResource.new()
	c.empty_dict["x"] = 1
	print("c.empty_dict size: ", c.empty_dict.size())
	print("c.empty_array size: ", c.empty_array.size())

	# Verify none of the dictionaries are read-only.
	var d := MyResource.new()
	print("empty_dict read_only: ", d.empty_dict.is_read_only())
	print("typed_dict read_only: ", d.typed_dict.is_read_only())
	print("empty_array read_only: ", d.empty_array.is_read_only())
	print("typed_array read_only: ", d.typed_array.is_read_only())
