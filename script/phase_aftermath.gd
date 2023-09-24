# phase_aftermath.gd
extends Phase

var unit : Unit


func enter(params := {}) -> void:
  print("aftermath")

func update(delta: float) -> void:
  if level.gameover:
    state_machine.transition_to("gameover")
  else:
    state_machine.transition_to("standby")
