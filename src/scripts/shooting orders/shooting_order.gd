class_name BaseShootingOrder extends Node

@export var bullet_scene: PackedScene
@export var time_between_each_attacks : float = 1
@export var damage : float = -1
@export var pooling_id: String
var parent_position : Vector2
@onready var manager : ShootingManager = get_parent()
var is_active = true
@onready var speed : float = get_children().filter(func(child): return child is BaseMovementOrder)[0].speed
var bullet : Bullet

## Boolean deciding if the projectile disapears with it's master (enemy who spawned the projectile). Since the spellcard can't "die" it's does nothing for friendly projectiles
@export var projectile_die_with_master = false

func ask_for_bullet_reserve(): #virtual method
	pass

## Provide a BulletConstructor for the Pool
func provide_constructor() -> BulletConstructor:
	var constructor : BulletConstructor = preload("res://src/scripts/Stage/bullet_constructor.gd").new()
	constructor.pooling_id = pooling_id
	constructor.bullet_scene = bullet_scene
	constructor.add_child(get_children().filter(func(child): return child is BaseMovementOrder)[0].duplicate())
	if $"Shooting Manager":
		constructor.add_child(get_children().filter(func(child): return child is ShootingManager)[0].duplicate())
	return constructor
	
func _ready():
	pooling_id += str(get_children().filter(func(child): return child is BaseMovementOrder)[0].duplicate().speed)
	$Timer.wait_time = time_between_each_attacks
	if manager.shooter_identity == manager.ShooterIdentityEnum.SPELLCARD :
		$Timer.stop()	
	ask_for_bullet_reserve()
	
func _process(delta):
	if manager.armed :
		if manager.shooter_identity == manager.ShooterIdentityEnum.SPELLCARD and Input.is_action_pressed("shoot"):
			_check_timer_before_shooting()
		elif manager.shooter_identity == manager.ShooterIdentityEnum.ENEMY :
			_check_timer_before_shooting()

func _check_timer_before_shooting():
	if $Timer.is_stopped() :
		$Timer.start()
		shoot()

func shoot(): #inherited function
		pass

func activate_bullet(direction: Vector2, rotation: float):
	bullet = manager.pool.provide_entity(pooling_id)
	manager.playing_field.add_child(bullet)
	bullet.position = manager._get_spawn_position()
	bullet.damage = damage
	if projectile_die_with_master :
		manager.get_parent().enemy_died.connect(bullet._on_master_death)
	direction = direction.rotated(rotation)
	bullet.find_child("Movement Manager").set_initial_direction(direction)
	bullet.rotation = direction.angle() + PI/2
	
		
	#
#func _on_shoot_timeout():
	#print("timeout")
	#shoot()
	#
#enum ShootingTypeEnum {
	#SIMPLEssss　　sddsssSssssssss
#}
#
#var nbOfWaves:int 
#var nbOfShots:int 
#var angle:float 
#var dt:float 
#var speed:float 
#var bulletClass:Bullet  
#var target:Vector2 = Vector2(0, 0)
#var shootingType: ShootingTypeEnum
#
#func _init(_shootingType:ShootingTypeEnum, _nbOfWaves:int, _nbOfShots:int, _angle:float, _dt:float, _speed:float, _bulletClass:Bullet,  _target:Vector2 = Vector2(0, 0)):
	#shootingType = _shootingType
	#target = _target
	#speed = _speed
	#dt = _dt
	#bulletClass = _bulletClass
	#angle = angle
	#nbOfWaves = _nbOfWaves
	#nbOfShots = _nbOfShots
