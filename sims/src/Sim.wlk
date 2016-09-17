import Trabajo.*
import Relacion.*

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
	var relacion = "soltero"
	var trabajo = "ninguno"
	var conocimientos = #{}


	constructor(unSexo, unaEdad, unDinero, unaPersonalidad, unSexoDePreferencia) {
		sexo = unSexo
		edad = unaEdad
		dinero = unDinero
		personalidad = unaPersonalidad
		sexoDePreferencia = unSexoDePreferencia
	}


//GETTERS Y SETTERS

	method edad() {
		return edad
	}

	method sexo() {
		return sexo
	}

	method personalidad() {
		return personalidad
	}

	method sexoDePreferencia() {
		return sexoDePreferencia
	}

	method conocimientos() {
		if(self.estaSoniador()) {
			return #{}
		}
		return conocimientos	
	}

	method amigos() {
		return amigos
	}

	method setAmigos(simsAmigos) {
		amigos = simsAmigos
	}

	method dinero() {
		return dinero
	}

	method setDinero(unaCantidad) {
		dinero = unaCantidad
	}

	method trabajo() {
		return trabajo
	}

	method setTrabajo(unTrabajo) {
		trabajo = unTrabajo
	}

	method nivelDeFelicidad() {
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

	method estadoDeAnimo() {
		return estadoDeAnimo
	}

	method setEstadoDeAnimo(unEstadoDeAnimo) {
		estadoDeAnimo = unEstadoDeAnimo
	}

	method relacion() {
		return relacion
	}	

	method setRelacion(unaRelacion) {
		relacion = unaRelacion
	}



//ABRAZOS

	method abrazarNormalmente(unSim) {
		self.modificarNivelDeFelicidad(2)
		unSim.modificarNivelDeFelicidad(4)
	}

	method abrazarProlongadamente(unSim) {
		if(unSim.leAtrae(self)) 
			unSim.ponerse(soniador)
		else 
			unSim.ponerse(incomodo)
		
	}



//AMISTAD

	method hacerseAmigoDe(unSim) {
		self.amigos().add(unSim)
		self.modificarNivelDeFelicidad(self.valorarA(unSim))
	}

	method hacerseAmigosCon(unSim) {
		self.hacerseAmigoDe(unSim)
		unSim.hacerseAmigoDe(self)
	}

	method esAmigoDe(unSim) {
		return self.amigos().contains(unSim)
	}

	method amigosMasRecientes() {
		return self.amigos().reverse().take(4)
	}

	method amigosMasAntiguos() {
		return self.amigos().take(4)
	}

	method nivelDePopularidad() {
		return self.amigos().sum{simAmigo => simAmigo.nivelDeFelicidad()}
	}

	method esMasPopularQue(unSim) {
		return self.nivelDePopularidad() >= unSim.nivelDePopularidad()
	}

	method esElMasPopularDeSusAmigos() {
		return self.amigos().all({unSim => self.esMasPopularQue(unSim)})
	}
	
	method tieneAmigos() {
		return not self.amigos().isEmpty()
	}



//EDAD

	method esJoven() {
		return self.edad().between(18, 29)
	}

//FELICIDAD

	method modificarNivelDeFelicidad(unValor) {
		self.setNivelDeFelicidad(self.nivelDeFelicidad() + unValor)
	}

	method estaTriste() {
		return self.nivelDeFelicidad() < 200 
	}

//VALORACION

	method valorarA(unSim) {
		return self.personalidad().valoracion(self, unSim)
	}

	method valoraMasA() {
		return self.amigos().max({unSim => self.valorarA(unSim)})
	}

//ATRACCION

	method lePodriaInteresar(unSim) {
		return unSim.sexo() == self.sexoDePreferencia()

	}

	method leAtrae(unSim) {
		return self.lePodriaInteresar(unSim) && self.personalidad().atraccion(self, unSim)
	}

	method leAtraen(muchosSims) {
		return muchosSims.filter({unSim => self.leAtrae(unSim)})
	}
	
	method leAtraeUnAmigoDeLaRelacion()
	{
		return self.amigosRelacion().any({unSim => self.leAtrae(unSim)})
	}
	
//RELACION

	method empezarRelacion(unSim)
	{
		var nuevaRelacion = new Relacion(self, unSim)
		self.setRelacion(nuevaRelacion) 
		unSim.setRelacion(nuevaRelacion)
	}
	method amigosRelacion()
	{
		return self.relacion().amigosRelacion()
	}
	
	method estaSoltero()
	{
		return self.relacion() == "soltero"
	}
	
	method pareja()
	{
		if(self.estaSoltero())
			error.throwWithMessage("No tiene pareja")
		return self.relacion().pareja(self)
	}
	
	method terminarRelacion()
	{
		
		relacion.terminar()
	}
	
	
//DINERO

	method dineroTotalAmigos() {
		return self.amigos().sum({unSim => unSim.dinero()})
	}

	method tieneMasDineroQue(unSim) {
		return self.dinero() > unSim.dinero()
	}

	method duplicarDinero() {
		return self.dinero() * 2
	}
	
	method recibirPago(unaCantidad) {
		self.setDinero(self.dinero() + unaCantidad)
	}

//TRABAJO

	method asignarTrabajo(unTrabajo) {
		self.setTrabajo(unTrabajo)
	}
	
	method tieneTrabajo() {
		return self.trabajo() != "ninguno"
	}
	
	method trabajar() {
		
		if(!self.tieneTrabajo())
        	error.throwWithMessage("Tu Sim no tiene trabajo")
        	
		self.recibirPago(self.trabajo().sueldo(self))
		self.trabajo().influirFelicidad(self)
		
		if(self.esBuenazo() && self.trabajaConTodosSusAmigos() && self.tieneAmigos() && self.tieneTrabajo()) {
			self.modificarNivelDeFelicidad(self.nivelDeFelicidad() * 0.1)
		}
	}
	
	method trabajaCon(unSim) {
		return self.trabajo() == unSim.trabajo()
		
	}
	
	method trabajaConTodosSusAmigos() {
		return self.amigos().all({unSim => self.trabajaCon(unSim)})	
	}
		
//PERSONALIDAD
	method esBuenazo() {
		return self.personalidad() == buenazo 
	}		
	
	
//CONOCIMIENTOS

	method adquirirConocimiento(unConocimiento) {
		self.conocimientos().add(unConocimiento)
	}

	method cuantoConoce() {
		return self.conocimientos().sum({unConocimiento => unConocimiento.length()})
	}

	method conoce(unConocimiento) {
		return self.conocimientos().contains(unConocimiento)
	}

	method contraerAmnesia() {
		self.conocimientos().clear()
	}

//ESTADOS DE ANIMO

	method estaSoniador() {
		return self.estadoDeAnimo() == soniador
	}

	method estaIncomodo() {
		return self.estadoDeAnimo() == incomodo
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
		return otroSim.dinero() >= unSim.duplicarDinero()
	}
}

object superficial {

	method valoracion(unSim, otroSim) {
		return 20 * otroSim.nivelDePopularidad()
	}

	method atraccion(unSim, otroSim) {
		return otroSim.esJoven() && unSim.amigos().all({sim => otroSim.esMasPopularQue(sim)})
	}
}

object buenazo {

	method valoracion(unSim, otroSim) {
		return 0.5 * unSim.nivelDeFelicidad()
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
		simCeloso.setAmigos(simCeloso.amigos().filter({unSim => simCeloso.tieneMasDineroQue(unSim)}))
		
	}
}

object popularidad {
	method romperAmistades(simCeloso) {
		simCeloso.setAmigos(simCeloso.amigos().filter({unSim => simCeloso.esMasPopularQue(unSim)}))
	}
}


object pareja {
	method romperAmistades(simCeloso) {
		simCeloso.setAmigos(simCeloso.amigos().filter({unSim => not simCeloso.pareja().esAmigoDe(unSim)}))
	}
}


//TIPOS DE ESTADOS DE ANIMOS

object normal {}
object soniador {}
object incomodo {}


//SIMS DE PRUEBA

object juan inherits Sim("hombre", 20, 50000, superficial, "mujer") {}
object pepita inherits Sim("mujer", 21, 1800, superficial, "hombre") {}
object pepe inherits Sim("hombre", 45, 4000, peleadoConLaVida, "mujer") {}
object martin inherits Sim("hombre", 20, 3000, interesado, "mujer") {}
object pablo inherits Sim("hombre", 40, 1000, buenazo, "hombre") {}
object carla inherits Sim("mujer", 21, 1000, interesado, "hombre") {}
object anastasia inherits Sim("mujer", 21, 99999, superficial, "hombre") {}
object icardi inherits Sim("hombre",21,999,superficial, "mujer") {}
object wanda inherits Sim("mujer", 40,999, peleadoConLaVida, "hombre" ) {}
