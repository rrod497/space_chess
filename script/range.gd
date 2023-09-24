class_name LineRange
extends Node2D

@export var unit = Unit

@export var range_size = 2
@export var range_texture : Texture2D


func get_range_cells():
  var cells = []
  for dir in [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]:
    for i in range_size:
      var cell = unit.coord + dir * (i + 1)
      if unit.map.unit_allowed_at(cell):
        cells.append(cell)
      else:
        break

#    cells.append(unit.coord + Vector2i.RIGHT * (i + 1))
#    cells.append(unit.coord + Vector2i.UP * (i + 1))
#    cells.append(unit.coord + Vector2i.DOWN *(i + 1))
  return cells.filter(func(c): return unit.map.unit_allowed_at(c))


func show_range():
  hide_range()
  for cell in get_range_cells():
    var sprite = Sprite2D.new()
    sprite.texture = range_texture
    sprite.position = unit.map.map_to_local(cell - unit.coord)
    sprite.offset = - unit.map.tile_set.tile_size / 2
    sprite.show_behind_parent = true
    add_child(sprite)


func hide_range():
  for n in get_children():
    remove_child(n)
    n.queue_free()
