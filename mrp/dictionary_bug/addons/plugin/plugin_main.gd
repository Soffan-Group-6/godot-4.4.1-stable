@tool
extends VBoxContainer

var res_a: MyResource
var res_b: MyResource

@onready var button_a: Button = $ButtonA
@onready var button_b: Button = $ButtonB

func _ready() -> void:
	button_a.pressed.connect(insert_a)
	button_b.pressed.connect(insert_b)

	# This is fine:
	#res_a = MyResource.new()
	#res_b = MyResource.new()

	# This is not:
	res_a = load("res://resource_a.tres")
	res_b = load("res://resource_b.tres")

func insert_a():
	res_a.data[randi()] = true
	info()

func insert_b():
	res_b.data[randi()] = true
	info()

func info():
	print("Resource A: ", str(res_a.data.keys()))
	print("Resource B: ", str(res_b.data.keys()))
