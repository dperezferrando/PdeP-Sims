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
	
	method amigosRelacion() {}
	method funciona() {}
	method sePudrioTodo() {}
	method hayOtrasAtracciones() {}
	method pareja(parejaSim) {}
	method terminar(){}	
	method termino(){}
	method miembros(){}	
	method reestablecer(){}
	method pertenece(algunSim){}
}