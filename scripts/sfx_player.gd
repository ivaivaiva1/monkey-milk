extends Node

var sounds: Dictionary = {}

@export var base_bus := "SFX"

func play_sfx(sound_data: Dictionary) -> void:
	if not sound_data or not sound_data.has("stream"):
		print("som inválido")
		return
	
	var stream: AudioStream = sound_data["stream"]
	var volume: float = sound_data.get("volume", 0.0)
	
	var path := stream.resource_path
	if path != "" and not sounds.has(path):
		sounds[path] = stream
	elif path != "":
		stream = sounds[path]
	
	var player := AudioStreamPlayer.new()
	player.stream = stream
	player.volume_db = volume
	player.bus = base_bus
	add_child(player)
	
	player.play()
	player.finished.connect(func(): player.queue_free())
