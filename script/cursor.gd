class_name Cursor
extends Unit

var move_enabled = true

func _process(delta):
  if move_enabled and not moving:
    var dir = Vector2i(Input.get_vector("left", "right", "up", "down"))
    if dir and map.cursor_allowed_at(coord + dir):
      move_by(dir)
  super(delta)
