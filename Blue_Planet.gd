extends RigidBody2D
class_name Box

func _physics_process(_delta):
	for i in get_colliding_bodies():
		print(i)
		if i.is_in_group("Player"):
				PlayerMovement.stop_movement = false

func _on_RigidBody2D_body_entered(body):
	print("Collision détectée avec", body.name)


func _on_body_entered(body):
	print(body.name)
