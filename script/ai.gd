class_name AI
extends Node


@export var unit = Unit

func take_movement():
  var cells = unit.range.get_range_cells()
  var cell = cells.pick_random()
  await get_tree().create_timer(1.0).timeout
  return cell

