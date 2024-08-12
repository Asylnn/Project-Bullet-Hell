class_name BaseShootingOrder extends Node

@export var bullet_scene: PackedScene
@export var time_between_each_attacks : float = 1
@export var damage_expression : String = "-1"
@export var angle_shift_expression : String  = "0"

## Does this order need to provide the movement order to the pool 
#@export var provide_movement_order : bool = true
var angle_shift : float :
	get:
		expr.parse(angle_shift_expression)
		return expr.execute([], self)

var wave : int = 1
var shot : int = 1
var salvo : int = 0
var expr = Expression.new()

@export var damage : float = -1 
	#get:
		#expr.parse(damage_expression)
		#return expr.execute()
	#set(value):
		#damage = value

var expiremental_damage : float :
	get:
		expr.parse(damage_expression)
		return expr.execute([], self)


@export var pooling_id: String
var parent_position : Vector2
@onready var manager : ShootingManager = get_parent()
var is_active = true
#@onready var speed : float = get_children().filter(func(child): return child is BaseMovementOrder)[0].speed
@export var speed_expression : String = "-1"
var speed :float : 
	get:
		expr.parse(speed_expression)
		return expr.execute([], self)

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
	if has_node("ShootingManager"):
		constructor.add_child(get_children().filter(func(child): return child is ShootingManager)[0].duplicate())
	return constructor
	
func _ready():
	#pooling_id += str(get_children().filter(func(child): return child is BaseMovementOrder)[0].duplicate().speed)
	$Timer.wait_time = time_between_each_attacks
	if manager.shooter_identity == manager.ShooterIdentityEnum.SPELLCARD :
		$Timer.stop()	
	ask_for_bullet_reserve()
	
func _process(delta): # potential for optimization
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
	
	bullet.position = manager._get_spawn_position()
	bullet.damage = damage
	#bullet.speed += speed
	#if damage_expression != "-1" :
		#print("damage expression", damage_expression)
		#print("damage" , damage)
		#print("exprimental damage", expiremental_damage)
	if projectile_die_with_master :
		manager.get_parent().enemy_died.connect(bullet._on_master_death)
	direction = direction.rotated(rotation)
	var bullet_manager = bullet.find_child("Movement Manager")
	bullet_manager.set_initial_direction(direction)
	if speed != -1 :
		bullet_manager.set_speed(speed)
	bullet.rotation = direction.angle() + PI/2
	manager.playing_field.add_child(bullet)
		
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
