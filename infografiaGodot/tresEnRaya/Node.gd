extends Node
var jugador : String
var fondos : Array
var sinNada = preload("res://nohay.png")
var xJugador = preload("res://images.png")
var oJugador = preload("res://o.png")
var ganador: bool = false
var perdiste: bool = false
var empate: bool = false
func fondo() -> void:
	fondos = ["0","0","0","0","0","0","0","0","0"]
	$VBoxContainer/HBoxContainer/TextureButton.texture_normal = sinNada
	$VBoxContainer/HBoxContainer/TextureButton2.texture_normal = sinNada
	$VBoxContainer/HBoxContainer/TextureButton3.texture_normal = sinNada	
	$VBoxContainer/HBoxContainer2/TextureButton4.texture_normal = sinNada
	$VBoxContainer/HBoxContainer2/TextureButton5.texture_normal = sinNada
	$VBoxContainer/HBoxContainer2/TextureButton6.texture_normal = sinNada
	$VBoxContainer/HBoxContainer3/TextureButton7.texture_normal = sinNada
	$VBoxContainer/HBoxContainer3/TextureButton8.texture_normal = sinNada
	$VBoxContainer/HBoxContainer3/TextureButton9.texture_normal = sinNada
	ganador = false
	perdiste = false
	empate = false
	
func principioJugador() -> void:
	jugador = "x"
	
func _ready() -> void:
	$MensajePerdiste.hide()
	fondo()
	principioJugador()
	
func estadoJugador() -> void:
	if jugador == "x":
		jugador = "o"
	else:
		jugador = "x"

func filaHecha() -> bool:
	var toques = 0
	for fila in range(3):
		for index in range(0 + toques, 3 + toques):
			if fondos[index] == jugador:
				ganador = true
			else:
				ganador = false
				break
		if ganador:
			return true
		toques += 3
	return false
	
func columnaHecha() -> bool:
	var toques = 0
	for col in range(3):
		for index in range(0 + toques, 7 + toques, 3):
			if fondos[index] == jugador:
				ganador = true
			else:
				ganador = false
				break
		if ganador:
			return true
		toques += 1
	return false
	

func diagonalHecha() -> bool:
	for i in range(0, 9, 4):
		if fondos[i] == jugador:
			ganador = true
		else:
			ganador = false
			break
	if ganador:
		return true
	for i in range(2, 7, 2):
		if fondos[i] == jugador:
			ganador = true
		else:
			ganador = false
			break
	if ganador:
		return true
	return false
	
func fondoLleno() -> bool:
	if fondos.has("0"):
		return false
	return true
	
func finDelJuego() -> void:
	if filaHecha() || columnaHecha() || diagonalHecha():
		perdiste = true
		mensajeFin()
	elif fondoLleno():
		perdiste = true
		empate = true
		mensajeFin()

func mensajeFin() -> void:
	if empate:
		$MensajePerdiste/VBoxContainer/Label.text = "empate!!!"
	else:
		$MensajePerdiste/VBoxContainer/Label.text = jugador + " gano!"
	$MensajePerdiste.show()

func jugadores(index: int) -> void:
	fondos[index] = jugador
	finDelJuego()

func espacioVacio(index: int) -> bool:
	if fondos[index] == "0":
		return true
	return false


func restablecerFondo(fila: int, index: int) -> void:
	var plantilla = "VBoxContainer/HBoxContainer" + String(fila) + "/TextureButton" + String(index)
	if jugador == "x":
		get_node(plantilla).texture_normal = xJugador
	elif jugador == "o":
		get_node(plantilla).texture_normal = oJugador
	estadoJugador()
	

func _on_TextureButton_button_up():
	if espacioVacio(0) && !perdiste:
		jugadores(0)
		restablecerFondo(0, 0)


func _on_TextureButton2_button_up():
	if espacioVacio(1) && !perdiste:
		jugadores(1)
		restablecerFondo(0, 1)


func _on_TextureButton3_button_up():
	if espacioVacio(2) && !perdiste:
		jugadores(2)
		restablecerFondo(0, 2)


func _on_TextureButton4_button_up():
	if espacioVacio(3) && !perdiste:
		jugadores(3)
		restablecerFondo(1, 3)


func _on_TextureButton5_button_up():
	if espacioVacio(4) && !perdiste:
		jugadores(4)
		restablecerFondo(1, 4)

func _on_TextureButton6_button_up():
	if espacioVacio(5) && !perdiste:
		jugadores(5)
		restablecerFondo(1, 5)


func _on_TextureButton7_button_up():
	if espacioVacio(6) && !perdiste:
		jugadores(6)
		restablecerFondo(2, 6)


func _on_TextureButton8_button_up():
	if espacioVacio(7) && !perdiste:
		jugadores(7)
		restablecerFondo(2, 7)


func _on_TextureButton9_button_up():
	if espacioVacio(8) && !perdiste:
		jugadores(8)
		restablecerFondo(2, 8)


func _on_Button_button_up():
	$MensajePerdiste.hide()
	fondo()
	principioJugador()
