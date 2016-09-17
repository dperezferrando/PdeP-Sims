class Relacion
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
		return unSim.leAtraeUnAmigoDeLaRelacion() || otroSim.leAtraeUnAmigoDeLaRelacion()
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
		unSim.setRelacion("soltero")
		otroSim.setRelacion("soltero")
	}
	
	method termino()
	{
		return unSim.relacion() != self || otroSim.relacion() != self
	}
	
	method miembros()
	{
		return [unSim, otroSim]
	}
	
	method reestablecer()
	{
		unSim.setRelacion(self)
		otroSim.setRelacion(self)
		
	}
	
	method pertenece(algunSim)
	{
		return algunSim.relacion() == self
	}
}