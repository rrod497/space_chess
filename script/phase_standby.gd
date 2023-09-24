# phase_standby.gd
extends Phase

var unit : Unit
var turn_queue : Array


func enter(params := {}) -> void:
  print("standby")
  if params.has("turn_queue"):
    turn_queue = params.turn_queue
  unit = turn_queue.pop_front()
  if unit == level.map.hero:
    level.turn = Level.Turn.Player
  else:
    level.turn = Level.Turn.Enemy


func update(delta: float) -> void:
  if not level.gameover:
    state_machine.transition_to("main", { unit=unit })


func exit():
  turn_queue.append(unit)
