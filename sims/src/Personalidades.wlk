object interesado {

	method valoracion(unSim, otroSim) {
		return 0.1 * otroSim.dineroTotalAmigos()
	}

	method atraccion(unSim, otroSim) {
		return otroSim.dinero() >= unSim.duplicarDinero()
	}
	
	method motivar(unSim) {}
	
	method cuantoPresta(unSim, otroSim) {
		return otroSim.dinero()
	}
}

object superficial {

	method valoracion(unSim, otroSim) {
		return 20 * otroSim.nivelDePopularidad()
	}

	method atraccion(unSim, otroSim) {
		return otroSim.esJoven() && unSim.amigos().all({sim => otroSim.esMasPopularQue(sim)})
	}
	
	method motivar(unSim) {}
	
	method cuantoPresta(unSim, otroSim) {
		return self.valoracion(unSim, otroSim)
	}
}

object buenazo {

	method valoracion(unSim, otroSim) {
		return 0.5 * unSim.nivelDeFelicidad()
	}

	method atraccion(unSim, otroSim) {
		return true
	}
	
	method motivar(unSim) {
		if(unSim.trabajaConTodosSusAmigos())
		unSim.modificarNivelDeFelicidad(unSim.nivelDeFelicidad() * 0.1)
	}
	
	method cuantoPresta(unSim, otroSim) {
		return self.valoracion(unSim, otroSim)
	}
}

object peleadoConLaVida {

	method valoracion(unSim, otroSim) {
		return 0
	}

	method atraccion(unSim, otroSim) {
		return otroSim.estaTriste()
	}
	
	method motivar(unSim) {}
	
	method cuantoPresta(unSim, otroSim) {
		return self.valoracion(unSim, otroSim)
	}
}