@tool
extends EditorPlugin

const PLUGIN = preload("res://addons/plugin/plugin_main.tscn")

var plugin

func _enter_tree():
	plugin = PLUGIN.instantiate()
	EditorInterface.get_editor_main_screen().add_child(plugin)
	_make_visible(false)


func _exit_tree():
	if plugin:
		plugin.queue_free()


func _has_main_screen():
	return true


func _make_visible(visible):
	if plugin:
		plugin.visible = visible


func _get_plugin_name():
	return "Plugin"


func _get_plugin_icon():
	return EditorInterface.get_editor_theme().get_icon("Joypad", "EditorIcons")
