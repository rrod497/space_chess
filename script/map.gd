class_name GameMap
extends TileMap

signal movement_submitted(unit, coord)


var hero : Unit
var enemies : Array[Unit]
var traps : Array[Unit]
var fixture : Array[Unit]
#var aStar : AStar2D
#var no_input : bool = false
@export var show_range : bool

func _ready():
  $cursor.coord = infer_coord($cursor)
  $hero.coord = infer_coord($hero)
  hero = $hero
  for unit in get_children():
    if unit.is_in_group("enemy"):
      unit.coord = infer_coord(unit)
      enemies.append(unit)
    if unit.is_in_group("trap"):
      unit.coord = infer_coord(unit)
      traps.append(unit)
#  astar_start()


func move_unit(unit, coord):
  if not unit.moving:
    unit.move_to(coord)

func find_path(unit, to):
  var path = []
  for j in range(abs(to.y - unit.coord.y)):
    if to.y > unit.coord.y:
      path.append(unit.coord + Vector2i.DOWN * (j + 1))
    else:
      path.append(unit.coord + Vector2i.UP * (j + 1))
  for i in range(abs(to.x - unit.coord.x)):
    if to.x > unit.coord.x:
      path.append(unit.coord + Vector2i.RIGHT * (i + 1))
    else:
      path.append(unit.coord + Vector2i.LEFT * (i + 1))
  return path

func get_turn_queue():
  var queue = [$hero]
  queue.append_array(enemies)
  return queue


func infer_coord(node):
  return local_to_map(node.position)


func infer_position(unit):
  return map_to_local(unit.coord)


func cursor_allowed_at(coord):
  return get_used_cells(0).has(coord)


func unit_allowed_at(coord):
  if not get_used_cells(0).has(coord): return false
  if hero.coord == coord: return false
  if enemies.any(func(u): return u.coord == coord): return false
  if fixture.any(func(u): return u.coord == coord): return false
  return true


func activate_at_cursor():
  print("activated at ", $cursor.coord)
#  var trigger = get_trigger_at($cursor.coord)
  if $hero.range.get_range_cells().has($cursor.coord):
#  level.submit_action("MOVE", { unit=$hero, coord=$cursor.coord })
    movement_submitted.emit($hero, $cursor.coord)

func disable_cursor_movement():
  $cursor.visible = false
  $cursor.move_enabled = false

func enable_cursor_movement():
  $cursor.visible = true
  $cursor.move_enabled = true

func show_range_for(unit):
#  if unit.has_node():
  unit.range.show_range()
#  has_node()

func hide_range_for(unit):
  unit.range.hide_range()

func request_movement_action(unit):
  var coord = await unit.ai.take_movement()
  movement_submitted.emit(unit, coord)

#
#func astar_start():
#  var size = self.get_used_rect().size
#  aStar = AStar2D.new()
#  aStar.reserve_space(size.x * size.y)
## Creates AStar grid
#  for i in size.x:
#      for j in size.y:
#          var idx=getAStarCellId(Vector2(i,j))
#          aStar.add_point(idx,Vector2(i,j))  #map_to_world(Vector2(i,j)))
#  # Fills AStar grid with info about valid tiles
#  for i in size.x:
#      for j in size.y:
#          if get_cell_source_id(0,Vector2(i,j))!=-1:
#              var idx=getAStarCellId(Vector2(i,j))
#              for vNeighborCell in [Vector2(i,j-1),Vector2(i,j+1),Vector2(i-1,j),Vector2(i+1,j)]:
#                  var idxNeighbor=getAStarCellId(vNeighborCell)
#                  if aStar.has_point(idxNeighbor) and not vNeighborCell in aSolidCells:
#                      aStar.connect_points(idx, idxNeighbor, false)
#
#func occupyAStarCell(vGlobalPosition:Vector2)->void:
#     var vCell:= vGlobalPosition #self.world_to_map(vGlobalPosition)
#     var idx:=getAStarCellId(vCell)
#     if aStar.has_point(idx):aStar.set_point_disabled(idx, true)
#func freeAStarCell(vGlobalPosition:Vector2)->void:
#     var vCell:= vGlobalPosition #self.world_to_map(vGlobalPosition)
#     var idx:=getAStarCellId(vCell)
#     if aStar.has_point(idx):aStar.set_point_disabled(idx, false)
#
#func getAStarCellId(vCell:Vector2)->int:
#  return int(vCell.y+vCell.x*self.get_used_rect().size.y)
