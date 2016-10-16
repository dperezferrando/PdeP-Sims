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
		error.throwWithMessage("Si el sim es desempleado, no tiene sueldo.")
	}
	
	method felicidadAfectada()
	{
		error.throwWithMessage("No se puede modificar la felicidad de un sim desempleado.")
	}
	
	method volverALaNormalidad(unSim)
	{
		error.throwWithMessage("No se puede cambiar el estado de un sim desempleado.")
	}
	
	method influirFelicidad(unSim)
	{
		error.throwWithMessage("No se puede modificar la felicidad de un sim desempleado.")
	}
}

object mecanico inherits TrabajoCopado(10, 100) {}
object ingeniero inherits TrabajoMercenario(0,0) {}
object barrendero inherits TrabajoAburrido(20, 30) {}
object ingenieroIndustrial inherits TrabajoMercenarioSocial(10,20){}