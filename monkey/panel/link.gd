extends Node2D

@export_group("Nodes")
@export
var node_1: DiagramNode
@export
var node_2: DiagramNode

func _ready() -> void:
	position = Vector2(0, 0)
	$Line2D.points[0] = node_1.position
	$Line2D.points[1] = node_2.position
