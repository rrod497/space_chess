# phase_init.gd
extends Phase

var turn_queue : Array

func enter(_msg := {}) -> void:
  print("init")
  turn_queue = level.map.get_turn_queue()


func update(delta: float) -> void:
  if not level.gameover:
    state_machine.transition_to("standby", { turn_queue=turn_queue })
