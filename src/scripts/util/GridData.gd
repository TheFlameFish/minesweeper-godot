class_name GridData extends Resource

var items: Dictionary
var default_instantiator: Callable

## `default_instantiator`: Should be a 
## runnable that returns an object you want to be your
## default item.
## It'll be called with its position as an argument
func _init(default_instantiator: Variant):
	var items = {}
	self.default_instantiator = default_instantiator
	
func set_item(position: Vector2i, item: Variant):
	items[position] = item

## Gets the item at the position. If nothing there,
## create default
func get_item_default(position: Vector2i):
	return items.get_or_add(position, \
		default_instantiator.call(position))

## Gets the item at the position,
## or null if nothing there
func get_item(position: Vector2i):
	return items.get(position)
	
## Returns a dictionary with position of item and
## item. Null if nothing there
func _get_with_position(position: Vector2i):
	return {
		'position': position, 
		'item': get_item(position)
	}
	
## Returns a dictionary with position of item and
## item. Null if nothing there
func _get_default_with_position(position: Vector2i):
	return {
		'position': position, 
		'item': get_item_default(position)
	}
	
## Populates the grid using the given instantiator for width and height
func populate(width: int, height: int, instantiator: Callable):
	for x in range(width):
		for y in range(height):
			set_item(Vector2(x,y), instantiator.call(Vector2i(x, y)))

## Populates grid with default for width and height
func populate_default(width: int, height: int):
	populate(width, height, default_instantiator)

## Returns all adjacent items to the position
## in dictionaries of 
## {position: Vector2i, item: Variant}
## in an array of length 8. Empty positions' items 
## will be null.
func get_adjacent(position: Vector2i) -> Array:
	var return_array = []
	for pos in get_adjacent_positions(position):
		return_array.append(_get_with_position(pos))
	return return_array
	
# Returns all adjacent items to the position
## in dictionaries of 
## {position: Vector2i, item: Variant}
## in an array of length 8. Empty positions' items 
## will be default.
func get_adjacent_defaults(position: Vector2i) -> Array:
	var return_array = []
	for pos in get_adjacent_positions(position):
		return_array.append(_get_default_with_position(pos))
	return return_array
	
func get_adjacent_positions(position: Vector2i) -> Array:
	return [
		position + Vector2i(-1, 0),
		position + Vector2i(-1, 1),
		position + Vector2i(0, 1),
		position + Vector2i(1, 1),
		position + Vector2i(1, 0),
		position + Vector2i(1, -1),
		position + Vector2i(0, -1),
		position + Vector2i(-1, -1),
	]
