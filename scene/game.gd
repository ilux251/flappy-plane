extends Node2D

const rerender_scene = "res://scene/rerender.tscn"

@export var layout: Array
@export var distance: int

var gamestart : bool = true
var preloaded_layouts : Array
var current_rerender : int = 1

func _ready() -> void:
	for l in layout:
		preloaded_layouts.append(load(l))
		
	rerender()

func _physics_process(delta: float) -> void:
	%CoinLabel.text = str(%Plane.coin)

func rerender() -> void:
	for index in preloaded_layouts.size():
		var new_instanace = preloaded_layouts[index].instantiate()
		new_instanace.global_position.x = distance * current_rerender
		get_tree().current_scene.call_deferred("add_child", new_instanace)
		
		if (index == 1):	
			var rerender_instance = load(rerender_scene).instantiate()
			rerender_instance.global_position.x = distance * current_rerender
			get_tree().current_scene.call_deferred("add_child", rerender_instance)
			
		current_rerender += 1
