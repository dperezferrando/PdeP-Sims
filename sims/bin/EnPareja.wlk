class EnPareja
{
	var amigosRelacion = #{}
	var unSim
	var otroSim
	
	constructor (_unSim, _otroSim)
	{
		unSim = _unSim
		otroSim = _otroSim
		amigosRelacion = unSim.amigos().asSet().union(otroSim.amigos())
	}
	
	method amigosRelacion()
	{
		return amigosRelacion
	}
	
	method funciona()
	{
		return unSim.leAtrae(otroSim) && otroSim.leAtrae(unSim)
	}
	
	method sePudrioTodo()
	{
		return !self.funciona() && self.hayOtrasAtracciones()
	}
	
	method hayOtrasAtracciones()
	{
		return self.miembros().any({algunSim => algunSim.leAtraeUnAmigoDeLaRelacion()})
	}
	
	method pareja(parejaSim)
	{
		if(parejaSim == unSim)
			return otroSim
		else
			return unSim		
	}
	
	method terminar()
	{
		unSim.setEstadoCivil(soltero)
		otroSim.setEstadoCivil(soltero)
	}
	
	method termino()
	{
		return self.miembros().any({algunSim => algunSim.estadoCivil() != self})
	}
	
	method miembros()
	{
		return [unSim, otroSim]
	}
	
	method reestablecer()
	{
		unSim.setEstadoCivil(self)
		otroSim.setEstadoCivil(self)
	}
	
	method pertenece(algunSim)
	{
		return self.miembros().contains(algunSim)
	}
}

object soltero {
	
	method amigosRelacion() {
		error.throwWithMessage("Un sim soltero no tiene un circulo de amigos de la relacion.")
	}
	method funciona() {
		error.throwWithMessage("No se puede saber si funciona la relacion de un sim soltero.")
	}
	method sePudrioTodo() {
		error.throwWithMessage("No se puede saber si se pudrio todo en la relacion de un sim soltero.")
	}
	method hayOtrasAtracciones() {
		error.throwWithMessage("Un sim soltero no tiene otras atracciones.")
	}
	method pareja(parejaSim) {
		error.throwWithMessage("Un sim soltero no tiene pareja.")
	}
	method terminar(){
		error.throwWithMessage("Un sim soltero no puede terminar su relacion.")
	}	
	method termino(){
		error.throwWithMessage("No se puede saber si termino la relacion de un sim soltero.")
	}
	method miembros(){
		error.throwWithMessage("No hay miembros de la relacion si el sim es soltero.")
	}
	method reestablecer(){
		error.throwWithMessage("No se puede restablecer la relacion si el sim es soltero.")
	}
	method pertenece(algunSim){
		error.throwWithMessage("No se puede saber si pertenece de un sim soltero.")
	}
}