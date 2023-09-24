class_name Unit
extends Node2D

signal moved(unit, coord)

@export var coord : Vector2i
@export var speed = 200
@onready var map : GameMap = get_parent()
var moving : bool = false
var move_target : Vector2i
var w = 0


func move_by(delta):
  move_to(coord + delta)


func move_to(coord):
  if map and not moving:
    move_target = coord
    w = 0
    moving = true


func _process(delta):
  if moving:
    w += (delta * speed) / map.map_to_local(coord).distance_to(map.map_to_local(move_target))
    if w < 1:
      position = map.map_to_local(coord).lerp(map.map_to_local(move_target), w)
    else:
      self.coord = move_target
      self.position = map.map_to_local(move_target)
      moving = false
      moved.emit(self, coord)
