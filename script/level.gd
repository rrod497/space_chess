class_name Level
extends Node2D

#enum Phase { StandBy, Main, Action, Effect }
enum Turn { Player, Enemy }

signal action_submitted(action, params)

#@export var turn = Turn.Player
@export var gameover = false
@onready var map : GameMap = $map
@export var turn : Turn = Turn.Player

#var turn_queue : Array
#
#func _ready():
#  turn_queue = map.get_turn_queue()
#
#func get_next_turn_unit():
#  turn_queue[0]



func _on_map_movement_submitted(unit, coord):
  action_submitted.emit("MOVE", {unit=unit, coord=coord})
