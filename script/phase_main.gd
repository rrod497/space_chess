# phase_main.gd
extends Phase

var action_submitted : bool
var action_params : Dictionary
var unit : Unit


func enter(params := {}) -> void:
  print("main")
  unit = params.unit
  level.map.show_range_for(unit)
  if level.turn == Level.Turn.Enemy:
    level.map.request_movement_action(unit)



func handle_input(event: InputEvent) -> void:
  if level.turn == Level.Turn.Player:
    if event.is_action_pressed("start"):
      print("start")
      level.map.activate_at_cursor()
#    else:
#      var dir = Vector2i(Input.get_vector("left", "right", "up", "down"))
#      if dir:
#        level.map.move_cursor(dir)



func update(delta: float) -> void:
  if level.gameover:
    state_machine.transition_to("gameover")
  elif action_submitted:
    state_machine.transition_to("movement", action_params)
#  elif Input.is_action_just_pressed("start"):
#    level.activate_cell()


func _on_level_action_submitted(action, params):
  if action == "MOVE":
    action_submitted = true
    action_params = params


func exit() -> void:
  level.map.hide_range_for(unit)
  action_submitted = false
