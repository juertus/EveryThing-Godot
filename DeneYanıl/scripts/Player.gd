extends Area2D
class_name Player

export (PackedScene) var Bullet  # to make a bullet instance
export (PackedScene) var Missile
var screen_size # to take a screen size limit

export var speed: int = 400 # speed variable
export var hp: int = 3 # health point variable
export var started_position: Vector2 = Vector2(57,296)

onready var shoot_point = $ShootPoint

func basic_movement(delta):
	var velocity = Vector2.ZERO
	
	velocity.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	velocity.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	
	velocity = velocity.normalized()
	position += velocity * speed * delta
	
func shoot():
	var bInstance = Bullet.instance()
	get_parent().add_child(bInstance)
	bInstance.global_position = shoot_point.global_position
	$ShootSound.play()

func superShoot():
	var missile_instance = Missile.instance()
	get_parent().add_child(missile_instance)
	missile_instance.global_position = shoot_point.global_position
	$ShootSound.play()

	
	
func take_tamage(damage):
	hp -= damage
	if hp <= 0:
		queue_free()
	
func _on_Player_area_entered(area):
	if area.is_in_group("enemies") or area.is_in_group("EnemyBullet"):
		take_tamage(1)
		$PlayerExplosionSound.play()
		position = started_position

func _ready():
	screen_size = get_viewport_rect().size

func screenLimits():
	position.x = clamp(position.x, 35, screen_size.x - 35)
	position.y = clamp(position.y, 35, screen_size.y - 35)

func _unhandled_input(event):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	if Input.is_action_just_pressed("super_shoot"):
		superShoot()
	
func _physics_process(delta):
	basic_movement(delta)
	screenLimits()

