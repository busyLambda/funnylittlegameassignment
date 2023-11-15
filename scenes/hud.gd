extends CanvasLayer

func _ready():
	update_health_bar()

func update_health_bar():
	var hb = get_parent().get_node("CharacterBody2D")
	
	$TextureProgressBar.value = hb.health
