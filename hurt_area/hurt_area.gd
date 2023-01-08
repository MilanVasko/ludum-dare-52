extends Area2D

export(float) var hurt_amount: float
export(float) var hurt_delay: float
var hurtable_objects := {}

func _process(delta: float):
	for ho in hurtable_objects:
		var delay: float = hurtable_objects[ho]
		delay -= delta

		if delay <= 0.0:
			ho._hurt(hurt_amount)
			delay = hurt_delay

		hurtable_objects[ho] = delay

func _on_object_entered(obj: Node2D) -> void:
	if obj.has_method("_hurt"):
		assert(!(obj in hurtable_objects))
		hurtable_objects[obj] = 0.0

func _on_object_exited(obj: Node2D) -> void:
	if obj.has_method("_hurt"):
		var ok := hurtable_objects.erase(obj)
		assert(ok)
