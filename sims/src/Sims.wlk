import Trabajos.*

class Sim
{
	var edad
	var sexo
	var dinero
	var personalidad
	var nivelDeFelicidad = 1000
	var estadoDeAnimo = normal
	var amigos = []
	var sexoDePreferencia
	var pareja = soltero
	var trabajo = ninguno
	var conocimientos = #{}


	constructor(unSexo, unaEdad, unDinero, unaPersonalidad, unSexoDePreferencia) {
		sexo = unSexo
		edad = unaEdad
		dinero = unDinero
		personalidad = unaPersonalidad
		sexoDePreferencia = unSexoDePreferencia
	}


//GETTERS Y SETTERS

	method getEdad() {
		return edad
	}

	method getSexo() {
		return sexo
	}

	method getPersonalidad() {
		return personalidad
	}

	method getSexoDePreferencia() {
		return sexoDePreferencia
	}

	method getConocimientos() {
		if(self.estaSoniador()) {
			return #{}
		}
		return conocimientos	
	}

	method getAmigos() {
		return amigos
	}

	method setAmigos(simsAmigos) {
		amigos = simsAmigos
	}

	method getDinero() {
		return dinero
	}

	method setDinero(unaCantidad) {
		dinero = unaCantidad
	}

	method getTrabajo() {
		return trabajo
	}

	method setTrabajo(unTrabajo) {
		trabajo = unTrabajo
	}

	method getNivelDeFelicidad() {
		if(self.estaSoniador()) {
			return nivelDeFelicidad + 1000
		}

		if(self.estaIncomodo()) {
			return nivelDeFelicidad - 200
		}

		return nivelDeFelicidad	
	}

	method setNivelDeFelicidad(unaCantidad) {
		nivelDeFelicidad = unaCantidad
	}

	method getEstadoDeAnimo() {
		return estadoDeAnimo
	}

	method setEstadoDeAnimo(unEstadoDeAnimo) {
		estadoDeAnimo = unEstadoDeAnimo
	}

	method getPareja() {
		return pareja
	}	

	method setPareja(unSim) {
		pareja = unSim
	}



//ABRAZOS

	method abrazarNormalmente(unSim) {
		self.modificarNivelDeFelicidad(2)
		unSim.modificarNivelDeFelicidad(4)
	}

	method abrazarProlongadamente(unSim) {
		if(unSim.leAtrae(self)) {
			unSim.ponerse(soniador)
		}
		else {
		unSim.ponerse(incomodo)
		}
	}



//AMISTAD

	method hacerseAmigoDe(unSim) {
		self.getAmigos().add(unSim)
		self.modificarNivelDeFelicidad(self.valorarA(unSim))
	}

	method hacerseAmigosCon(unSim) {
		self.hacerseAmigoDe(unSim)
		unSim.hacerseAmigoDe(self)
	}

	method esAmigoDe(unSim) {
		return self.getAmigos().contains(unSim)
	}

	method amigosMasRecientes() {
		return self.getAmigos().reverse().take(4)
	}

	method amigosMasAntiguos() {
		return self.getAmigos().take(4)
	}

	method nivelDePopularidad() {
		return self.getAmigos().sum{simAmigo => simAmigo.getNivelDeFelicidad()}
	}

	method esMasPopularQue(unSim) {
		return self.nivelDePopularidad() > unSim.nivelDePopularidad()
	}

	method esElMasPopularDeSusAmigos() {
		return self.getAmigos().all({unSim => self.esMasPopularQue(unSim)})
	}
	
	method tieneAmigos() {
		return not self.getAmigos().isEmpty()
	}



//EDAD

	method esJoven() {
		return self.getEdad().between(18, 29)
	}

//FELICIDAD

	method modificarNivelDeFelicidad(unValor) {
		self.setNivelDeFelicidad(self.getNivelDeFelicidad() + unValor)
	}

	method estaTriste() {
		return self.getNivelDeFelicidad() < 200 
	}

//VALORACION

	method valorarA(unSim) {
		return self.getPersonalidad().valoracion(self, unSim)
	}

	method valoraMasA() {
		return self.getAmigos().max({unSim => self.valorarA(unSim)})
	}

//ATRACCION

	method lePodriaInteresar(unSim) {
		return unSim.getSexo() == self.getSexoDePreferencia() 

	}

	method leAtrae(unSim) {
		return self.lePodriaInteresar(unSim) && self.getPersonalidad().atraccion(self, unSim)
	}

	method leAtraen(muchosSims) {
		return muchosSims.filter({unSim => self.leAtrae(unSim)})
	}
	
//DINERO

	method dineroTotalAmigos() {
		return self.getAmigos().sum({unSim => unSim.getDinero()})
	}

	method tieneMasDineroQue(unSim) {
		return self.getDinero() > unSim.getDinero()
	}

	method duplicarDinero() {
		return self.getDinero() * 2
	}
	
	method recibirPago(unaCantidad) {
		self.setDinero(self.getDinero() + unaCantidad)
	}

//TRABAJO

	method asignarTrabajo(unTrabajo) {
		self.setTrabajo(unTrabajo)
	}
	
	method tieneTrabajo() {
		return self.getTrabajo() != ninguno
	}
	
	method tieneTrabajoMercenario() {
		return self.getTrabajo().getTipo() == mercenario
	}

	method trabajar() {

		if(self.esBuenazo() && self.trabajaConTodosSusAmigos() && self.tieneAmigos() && self.tieneTrabajo()) {
			self.modificarNivelDeFelicidad(self.getNivelDeFelicidad() * 0.1)
		}
		if(self.tieneTrabajoMercenario()) {
			self.recibirPago(100 + 0.02 * self.getDinero())
		}
		else {
			self.recibirPago(self.getTrabajo().getSalario())
			self.modificarNivelDeFelicidad(self.getTrabajo().getFelicidad())
		}
	}
	
	method trabajaCon(unSim) {
		return self.getTrabajo() == unSim.getTrabajo()
	}
	
	method trabajaConTodosSusAmigos() {
		return self.getAmigos().all({unSim => self.trabajaCon(unSim)})	
	}
		
//PERSONALIDAD
	method esBuenazo() {
		return self.getPersonalidad() == buenazo 
	}		
	
	
//CONOCIMIENTOS

	method adquirirConocimiento(unConocimiento) {
		self.getConocimientos().add(unConocimiento)
	}

	method cuantoConoce() {
		return self.getConocimientos().sum({unConocimiento => unConocimiento.length()})
	}

	method conoce(unConocimiento) {
		return self.getConocimientos().contains(unConocimiento)
	}

	method contraerAmnesia() {
		self.getConocimientos().clear()
	}

//ESTADOS DE ANIMO

	method estaSoniador() {
		return self.getEstadoDeAnimo() == soniador
	}

	method estaIncomodo() {
		return self.getEstadoDeAnimo() == incomodo
	}

	method ponerse(unEstadoDeAnimo) {
		self.setEstadoDeAnimo(unEstadoDeAnimo)
	}

// CELOS

	method ponerseCelosoPor(motivo) {
		self.modificarNivelDeFelicidad(-10)
		motivo.romperAmistades(self)
	}

}

//PERSONALIDADES

object interesado {

	method valoracion(unSim, otroSim) {
		return 0.1 * otroSim.dineroTotalAmigos()
	}

	method atraccion(unSim, otroSim) {
		return otroSim.getDinero() >= unSim.duplicarDinero()
	}
}

object superficial {

	method valoracion(unSim, otroSim) {
		return 20 * otroSim.nivelDePopularidad()
	}

	method atraccion(unSim, otroSim) {
		return otroSim.esJoven() && unSim.getAmigos().all({sim => otroSim.esMasPopularQue(sim)})
	}
}

object buenazo {

	method valoracion(unSim, otroSim) {
		return 0.5 * unSim.getNivelDeFelicidad()
	}

	method atraccion(unSim, otroSim) {
		return true
	}
	
}

object peleadoConLaVida {

	method valoracion(unSim, otroSim) {
		return 0
	}

	method atraccion(unSim, otroSim) {
		return otroSim.estaTriste()
	}
}


// MOTIVOS DE CELOS

object dinero {
	method romperAmistades(simCeloso) {
		simCeloso.setAmigos(simCeloso.getAmigos().filter({unSim => simCeloso.tieneMasDineroQue(unSim)}))
	}
}

object popularidad {
	method romperAmistades(simCeloso) {
		simCeloso.setAmigos(simCeloso.getAmigos().filter({unSim => simCeloso.esMasPopularQue(unSim)}))
	}
}


object pareja {
	method romperAmistades(simCeloso) {
		simCeloso.setAmigos(simCeloso.getAmigos().filter({unSim => not simCeloso.getPareja().esAmigoDe(unSim)}))
	}
}


//TIPOS DE ESTADOS DE ANIMOS

object normal {}
object soniador {}
object incomodo {}


// TIPOS DE SEXO

object hombre {}
object mujer {}

//SIN RELACION
object soltero {}

//SIMS DE PRUEBA

object juan inherits Sim(hombre, 20, 100, superficial, mujer) {}
object pepita inherits Sim(mujer, 21, 50000, superficial, hombre) {}
object pepe inherits Sim(hombre, 45, 4000, buenazo, mujer) {}
object martin inherits Sim(hombre, 20, 1000, interesado, mujer) {}
object pablo inherits Sim(hombre, 40, 1000, peleadoConLaVida, hombre) {}

