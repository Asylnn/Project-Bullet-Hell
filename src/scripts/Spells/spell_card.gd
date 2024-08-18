class_name SpellCard extends Control

@export var shot_type : ShotType = ShotType.Mixed
@export var spellcard_name : String = "Spellcard"

enum ShotType {
	Focus,
	Spread,
	Homing,
	Mixed
}
