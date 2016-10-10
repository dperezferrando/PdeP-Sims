class EstadoDeAnimo {
	
	var felicidadAdicional
	
	constructor(unaCantidad) {
		felicidadAdicional = unaCantidad
	}
	
	method felicidadAdicional() {
		return felicidadAdicional
	}
	
	method hacerEfecto(unSim) {
		unSim.modificarNivelDeFelicidad(felicidadAdicional)
	}
}

object soniador inherits EstadoDeAnimo(1000) {}

object incomodo inherits EstadoDeAnimo(-200) {}

object normal inherits EstadoDeAnimo(0) {
	
	override method hacerEfecto(unSim) {
		if(not unSim.estaNormal()) 
			unSim.modificarNivelDeFelicidad(-unSim.estadoDeAnimo().felicidadAdicional())
	}
}