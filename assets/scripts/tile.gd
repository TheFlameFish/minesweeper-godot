class_name Tile extends Node2D

## If this tile is a mine, emitted when it's clicked
signal detonated

@export var number: int = 0

@export var revealed: bool = false
@export var flagged: bool = false

## Whether this tile is a mine 
## and will explode upon click
@export var is_mine = false

const num_icons = [
	null,
	"res://assets/images/tile/tile_Num-1.png",
	"res://assets/images/tile/tile_Num-2.png",
	"res://assets/images/tile/tile_Num-3.png",
	"res://assets/images/tile/tile_Num-4.png",
	"res://assets/images/tile/tile_Num-5.png",
	"res://assets/images/tile/tile_Num-6.png",
	"res://assets/images/tile/tile_Num-7.png",
	"res://assets/images/tile/tile_Num-8.png",
]

const mystery_icon = "res://assets/images/tile/tile_Mystery.png"
const mine_icon = "res://assets/images/tile/tile_Mine.png"

## Sets the icon using the given path.
## `icon_path` should be string or null.
## If `icon_path` is null, hide cover.
func set_icon(icon_path: Variant) -> void:
	if icon_path != null:
		$cover.texture = load(icon_path)
	$cover.visible = icon_path != null

func _process(_delta: float) -> void:
	if (not revealed):
		set_icon(mystery_icon)
	elif (is_mine):
		set_icon(mine_icon)
	else:
		set_icon(num_icons[number])
	
	$flag.visible = flagged

func _on_collider_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("ui_touch"):
		revealed = true
		detonated.emit()
	else:
		pass
