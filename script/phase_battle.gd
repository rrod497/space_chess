# phase_battle.gd
extends Phase

var unit : Unit


func enter(params := {}) -> void:
  print("battle")
  unit = params.unit

func update(delta: float) -> void:
  if level.gameover:
    state_machine.transition_to("gameover")
  else:
    state_machine.transition_to("aftermath")
