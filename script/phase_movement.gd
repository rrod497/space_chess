# phase_movement.gd
extends Phase

var coord : Vector2i
var unit : Unit
var path = []
var taget

func enter(params := {}) -> void:
  print("movement")
  unit = params.unit
  coord = params.coord
  path = level.map.find_path(unit, coord)
  unit.moved.connect(_on_unit_moved) #.bind(unit))

func update(delta: float) -> void:
  if level.gameover:
    state_machine.transition_to("gameover")
  elif path.is_empty():
    state_machine.transition_to("battle", { unit=unit })
  elif taget != path[0]:
      taget = path[0]
      level.map.move_unit(unit, taget)

func exit():
  unit.moved.disconnect(_on_unit_moved)


func _on_unit_moved(unit, coord):
  path.erase(coord)
#  if not path.is_empty():
#    var i = path.find(coord)
