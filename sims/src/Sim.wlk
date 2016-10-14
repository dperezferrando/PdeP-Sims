import Trabajo.*
import EnPareja.*
import EstadoDeAnimo.*
import Personalidades.*
import Celos.*
import FuentesDeInformacion.*

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
	var estadoCivil = soltero
	var trabajo = desempleado
	var conocimientos = #{}
	var fuentesDeInformacion = #{}

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
	
	method setConocimientos(unosConocimientos) {
		conocimientos = unosConocimientos
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
	
	method fuentesDeInformacion() {
		return fuentesDeInformacion
	}

	method setTrabajo(unTrabajo) {
		trabajo = unTrabajo
	}

	method nivelDeFelicidad() {
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

	method estadoCivil() {
		return estadoCivil
	}	

	method setEstadoCivil(unaRelacion) {
		estadoCivil = unaRelacion
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

	method agregarAmigo(unSim) {
		self.amigos().add(unSim)
	}
	
	method hacerseAmigoDe(unSim) {
		self.agregarAmigo(unSim)
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
		var nuevaRelacion = new EnPareja(self, unSim)
		self.setEstadoCivil(nuevaRelacion) 
		unSim.setEstadoCivil(nuevaRelacion)
	}
	method amigosRelacion()
	{
		return self.estadoCivil().amigosRelacion()
	}
	
	method pareja()
	{
		return self.estadoCivil().pareja(self)
	}
	
	method terminarRelacion()
	{
		self.estadoCivil().terminar()
	}
	
	method estaSoltero()
	{
		return self.estadoCivil() == soltero
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
	
	method recibirPago() {
		self.setDinero(self.dinero() + self.trabajo().sueldo(self))
	}
	
	method modificarDinero(unaCantidad) {
		self.setDinero(self.dinero() + unaCantidad)
	}
	
	method puedePrestar(unaCantidad) {
		return unaCantidad <= self.dinero()
	}
	
	method lePrestariaA(unSim, unaCantidad) {
		return self.lePrestaComoMuchoA(unSim) >= unaCantidad
	}
	
	method prestarDineroA(unSim, unaCantidad) {
		if(not self.puedePrestar(unaCantidad) || not self.lePrestariaA(unSim, unaCantidad)) {
			error.throwWithMessage("El sim no puede o no quiere prestar esa cantidad")
		}
		self.modificarDinero(-unaCantidad)
		unSim.modificarDinero(unaCantidad)
	}
	
	method lePrestaComoMuchoA(unSim) {
		return self.personalidad().cuantoPresta(self ,unSim)
	}

//TRABAJO

	method asignarTrabajo(unTrabajo) {
		self.setTrabajo(unTrabajo)
	}
	
	method tieneTrabajo() {
		return self.trabajo() != desempleado
	}
	
	method trabajar() {	
		self.recibirPago()
		self.trabajo().influirFelicidad(self)
		self.personalidad().motivar(self)
		self.trabajo().volverALaNormalidad(self)
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
	
	method difundir(unConocimiento) {
		self.adquirirConocimiento(unConocimiento)
		self.amigos().forEach({unSim => unSim.adquirirConocimiento(unConocimiento)})
	}
	
	method nadieLoSabe(unConocimiento) {
		return self.amigos().all({unSim => not unSim.conoce(unConocimiento)}) 
	}
	
	method esPrivado(unConocimiento) {
		return self.conoce(unConocimiento) && self.nadieLoSabe(unConocimiento)
	}
	
	method conocimientosPrivados() {
		return self.conocimientos().filter({unConocimiento => self.esPrivado(unConocimiento)})
	}
	
	method desparramarChismeSobre(unSim) {
		self.difundir(unSim.conocimientosPrivados().anyOne())
	}
	
	method darInformacion() {
		return self.amigos().random().conocimientosPrivados().anyOne()
	}
	
	method adquirirConocimientos(unosConocimientos) {
		self.setConocimientos(self.conocimientos() + unosConocimientos)
	}

//ESTADOS DE ANIMO

	method estaSoniador() {
		return self.estadoDeAnimo() == soniador
	}

	method estaIncomodo() {
		return self.estadoDeAnimo() == incomodo
	}
	
	method estaNormal() {
		return self.estadoDeAnimo() == normal
	}
	
	method ponerse(unEstadoDeAnimo) {
		unEstadoDeAnimo.hacerEfecto(self)
		self.setEstadoDeAnimo(unEstadoDeAnimo)	
	}

// CELOS

	method ponerseCelosoPor(motivo) {
		self.modificarNivelDeFelicidad(-10)
		motivo.romperAmistades(self)
	}
		
// FUENTES DE INFORMACION

	method agregarFuente(unaFuente) {
		self.fuentesDeInformacion().add(unaFuente)
	}
	
	method obtenerInformacion(unaFuente) {
		self.adquirirConocimiento(unaFuente.darInformacion())
	}
	
	method informarse() {
		self.adquirirConocimientos(self.fuentesDeInformacion().map({unaFuente => self.obtenerInformacion(unaFuente)})) 
	}

}


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
