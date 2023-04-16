extends Area2D
class_name Missile

export var speed: int = 200
var hp: int = 1

func _process(delta):
	position.x += speed * delta

func take_damage(damage):
	hp -= damage
	if hp == 0:
		queue_free()

func _on_Missile_area_entered(area):
	if area.is_in_group("enemies"):
		take_damage(1)
