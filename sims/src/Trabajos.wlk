class Trabajo { // Abstracta
	
	var felicidadAfectada
	var sueldo
	
	/*constructor(unSueldo, unaFelicidad)
	{
		sueldo = unSueldo
		felicidadAfectada = unaFelicidad
	}*/
	
	method sueldo(unSim)
	{
		return sueldo
	}
	
	method felicidadAfectada()
	{
		return felicidadAfectada
	}
	
}

class TrabajoCopado inherits Trabajo {
	
	constructor(unSueldo, unaFelicidad) // Porque la herencia esta rota
	{
		sueldo = unSueldo
		felicidadAfectada = unaFelicidad
	}
	
	method influirFelicidad(unSim)
	{
		unSim.modificarNivelDeFelicidad(felicidadAfectada)	
	}
}

class TrabajoAburrido inherits Trabajo {
	
	constructor(unSueldo, unaFelicidad) // Porque la herencia esta rota
	{
		sueldo = unSueldo
		felicidadAfectada = unaFelicidad
	}
	
	method influirFelicidad(unSim)
	{
		unSim.modificarNivelDeFelicidad(-felicidadAfectada)	
	}
}

class TrabajoMercenario { // Hereda?
	
	method sueldo(unSim)
	{
		return 100 + (0.02*unSim.dinero())
	}
	
	method influirFelicidad(unSim)
	{
		
	}
}

//TRABAJOS DE PRUEBA
object mecanico inherits TrabajoCopado(10, 100) {}
object ingeniero inherits TrabajoMercenario {}
object barrendero inherits TrabajoAburrido(20, 30) {}
