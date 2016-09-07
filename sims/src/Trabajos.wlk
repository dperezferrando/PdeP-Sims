class Trabajo {
	
	var salario 
	var felicidad
	var tipo
	
	constructor (unSalario, unaCantidad, unTipo) {
		salario = unSalario
		felicidad = unaCantidad
		tipo = unTipo
	}
	
	method getSalario() {
		return salario
	}
	
	method getFelicidad() {
		return felicidad
	}
	
	method getTipo() {
		return tipo
	}
	
}

//TRABAJOS DE PRUEBA
object mecanico inherits Trabajo(10, 100, copado) {}
object ingeniero inherits Trabajo(0, 0, mercenario) {}
object barrendero inherits Trabajo(20, -30, aburrido) {}
object ninguno inherits Trabajo(0, 0, aburrido) {}


//TIPOS DE TRABAJO
object copado {}
object mercenario {} 
object aburrido {}