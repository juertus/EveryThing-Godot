extends Area2D
class_name Enemy

export (PackedScene) var EnemyBullet

onready var enemy_bullet_position = $EnemyBulletPosition
export var speed: int = 100
var hp: int = 5

func _process(delta):
	position.x -= speed * delta

func take_damage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()

func enemy_shoot():
	var enemy_bullet_instance = EnemyBullet.instance()
	get_parent().add_child(enemy_bullet_instance)
	enemy_bullet_instance.global_position = enemy_bullet_position.global_position
	$ShootSound.play()

func _on_Enemy_area_entered(area):
	$Enemy1ExplosionSound.play()
	if area.is_in_group("Bullet") or area.is_in_group("Player"):
		take_damage(1)
	if area.is_in_group("Missile"):
		take_damage(5)
	
	

func _on_Timer_timeout():
	enemy_shoot()
