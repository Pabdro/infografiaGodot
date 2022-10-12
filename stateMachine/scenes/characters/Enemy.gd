extends KinematicBody2D

export(int) var w_range = 50

var speed = 200
var accel = 2
var vivo = true
var velocity = Vector2.ZERO
onready var state_machine = $AnimationTree.get("parameters/playback")
onready var start_position = global_position
onready var target_position = global_position
onready var timer = $Timer

func update_target_position():
	if vivo == true:
		var target_vector = Vector2(rand_range(-w_range, w_range), rand_range(-w_range, w_range))
		print(target_vector)
		target_position = start_position + target_vector
		state_machine.travel("walk")

func _physics_process(delta):
	if vivo == true:
		var direction = global_position.direction_to(target_position)
		if direction.x < 0:
			$Sprite.scale.x = -1
		else:
			$Sprite.scale.x = 1
		velocity = velocity.move_toward(direction * speed, accel * delta)
		if global_position.distance_to(target_position) < 0.1:
			state_machine.travel("idle")
			velocity = Vector2.ZERO
		move_and_slide(velocity)

func _on_Timer_timeout():
	if vivo == true: 
		print("mover")
		update_target_position()
		var duration = rand_range(9, 15)
		timer.start(duration)

func _on_AreaMuerte_area_entered(area):
	if area.is_in_group("hit"):
		state_machine.travel("dead")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "dead":
		queue_free()
