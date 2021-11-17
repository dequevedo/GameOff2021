extends CollisionShape

func _init():
	var sphereshape = SphereShape.new()
	sphereshape.set_radius(1.3)
	set_shape(sphereshape)

func _ready():
	pass
