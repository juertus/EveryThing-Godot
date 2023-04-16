extends Area2D
class_name EnemyBullet

export var speed: int = 500
var hp: int = 1

func _process(delta):
	position.x += speed * delta

func take_damage(damage):
	hp -= damage
	if hp == 0:
		queue_free()

func _on_Bullet_area_entered(area):
	if area.is_in_group("enemies") or area.is_in_group("EnemyBullet"):
		take_damage(1)
