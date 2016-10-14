import EstadoDeAnimo.normal

class Trabajo { // Abstracta
	
	var felicidadAfectada
	var sueldo
	
	constructor(unSueldo, unaFelicidad)
	{
		sueldo = unSueldo
		felicidadAfectada = unaFelicidad
	}
	
	method sueldo(unSim)
	{
		return sueldo
	}
	
	method felicidadAfectada()
	{
		return felicidadAfectada
	}
	
	method volverALaNormalidad(unSim)
	{
		unSim.setEstadoDeAnimo(normal)	
	}
	
}

class TrabajoCopado inherits Trabajo {
	
	constructor(unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad)
	
	method influirFelicidad(unSim)
	{
		unSim.modificarNivelDeFelicidad(felicidadAfectada)	
	}
}

class TrabajoAburrido inherits Trabajo {
	
	constructor(unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad)
	
	method influirFelicidad(unSim)
	{
		unSim.modificarNivelDeFelicidad(-felicidadAfectada)	
	}
}

class TrabajoAburridoHastaLaMuerte inherits TrabajoAburrido {
	
	constructor(unSueldo, unaFelicidad) = super(unSueldo, 10*unaFelicidad)
	
}

class TrabajoMercenario inherits Trabajo {
	
	constructor(unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad)
	
	override method sueldo(unSim)
	{
		return 100 + (0.02*unSim.dinero())
	}
	
	method influirFelicidad(unSim)
	{
		
	}
}

class TrabajoMercenarioSocial inherits TrabajoMercenario {
	
	constructor(unSueldo, unaFelicidad) = super(unSueldo, unaFelicidad)
	
	override method sueldo(unSim)
	{
		
		return super(unSim)+self.comision(unSim)
				
	}
	
	method comision(unSim)
	{
		return unSim.amigos().size()
	}
}

//TRABAJOS DE PRUEBA

object desempleado {
	method sueldo(unSim)
	{
		return 0
	}
	
	method felicidadAfectada()
	{
		return 0
	}
	
	method volverALaNormalidad(unSim)
	{
			
	}
	
	method influirFelicidad(unSim)
	{
		
	}
}

object mecanico inherits TrabajoCopado(10, 100) {}
object ingeniero inherits TrabajoMercenario(0,0) {}
object barrendero inherits TrabajoAburrido(20, 30) {}
object ingenieroIndustrial inherits TrabajoMercenarioSocial(10,20){}