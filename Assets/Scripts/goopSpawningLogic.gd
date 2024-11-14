extends Node2D

# Preload the goop particle scene
var GoopParticle = preload("res://Scenes/Level/Components/Ooz.tscn")

# Number of particles to spawn at once
var particles_per_spawn = 10  # You can adjust this number

func _ready():
	print("Game ready, starting timer...")

	# Ensure GoopParticle is valid
	if GoopParticle:
		print("Goop particle scene preloaded successfully.")
	else:
		print("Failed to preload Goop particle scene!")
		return  # Stop further execution if the scene is not loaded

	# Start the infinite spawning loop
	spawn_particles_with_random_intervals()

func spawn_particles_with_random_intervals():
	# Loop to spawn multiple particles at random intervals
	for i in range(particles_per_spawn):
		var random_delay = randf_range(0.1, 2.5)  # Random delay between 0.1 and 0.5 seconds
		var spawn_timer = Timer.new()
		spawn_timer.wait_time = random_delay
		spawn_timer.one_shot = true
		spawn_timer.connect("timeout", Callable(self, "_spawn_single_goop_particle"))
		add_child(spawn_timer)
		spawn_timer.start()

	# After spawning this batch, call the function again to spawn more indefinitely
	var repeat_timer = Timer.new()
	repeat_timer.wait_time = 1  # Repeat every 1 second (adjust this as needed)
	repeat_timer.one_shot = true
	repeat_timer.connect("timeout", Callable(self, "spawn_particles_with_random_intervals"))
	add_child(repeat_timer)
	repeat_timer.start()

func _spawn_single_goop_particle():
	# Declare goop_instance variable first
	var goop_instance

	# Check if GoopParticle is valid before instancing
	if GoopParticle:
		goop_instance = GoopParticle.instantiate()  # Use instantiate() instead of instance() in Godot 4
		print("Goop particle instantiated.")
	else:
		print("GoopParticle is not valid, cannot instance!")
		return  # Stop execution if instancing failed

	goop_instance.position = Vector2(0, 0)
	
	# Log the position for debugging
	print("Goop particle spawned at position: ", goop_instance.position)
	
	# Add the goop particle to the scene
	add_child(goop_instance)
	
	# Optional: apply some initial random force to make the goop more dynamic
	var random_velocity = Vector2(randf_range(-200, 200), randf_range(-200, 200))
	goop_instance.apply_impulse(Vector2.ZERO, random_velocity)
	
	# Log the initial velocity for debugging
	print("Goop particle given initial velocity: ", random_velocity)
	
	# Create a timer to despawn the particle after 0.5 seconds
	var despawn_timer = Timer.new()
	despawn_timer.wait_time = 1
	despawn_timer.one_shot = true
	despawn_timer.connect("timeout", Callable(self, "_despawn_particle").bind(goop_instance))
	add_child(despawn_timer)
	despawn_timer.start()

# Despawn the particle
func _despawn_particle(goop_instance):
	if goop_instance and goop_instance.is_inside_tree():
		goop_instance.queue_free()
		print("Goop particle despawned.")
