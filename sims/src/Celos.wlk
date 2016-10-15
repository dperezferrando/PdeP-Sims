class Celos {
	
	method ataqueCelos(unSim)
	{
		unSim.modificarNivelDeFelicidad(-10)
		self.celarAmigos(unSim)
	}
	
	method celarAmigos(unSim)
	{
		
	}
	
}

class CelosPorPlata inherits Celos {
	
	override method celarAmigos(unSim)
	{
		unSim.filtrarAmigos(unSim,{otroSim => unSim.tieneMasDineroQue(otroSim)})
	}
	
}

class CelosPorPopularidad inherits Celos {
	
	override method celarAmigos(unSim)
	{
		unSim.filtrarAmigos(unSim,{otroSim => unSim.esMasPopularQue(otroSim)})
	}
	
}

class CelosPorPareja inherits Celos {
	
	override method celarAmigos(unSim)
	{
		unSim.filtrarAmigos(unSim,{otroSim => not unSim.pareja().esAmigoDe(otroSim)})
	}
	
}

object porPlata inherits CelosPorPlata {}
object porPopularidad inherits CelosPorPopularidad {}
object porPareja inherits CelosPorPareja {}

//object dinero {
//	
//	method romperAmistades(simCeloso) {
//		simCeloso.setAmigos(simCeloso.amigos().filter({unSim => simCeloso.tieneMasDineroQue(unSim)}))
//		
//	}
//}
//
//object popularidad {
//	method romperAmistades(simCeloso) {
//		simCeloso.setAmigos(simCeloso.amigos().filter({unSim => simCeloso.esMasPopularQue(unSim)}))
//	}
//}
//
//
//object pareja {
//	method romperAmistades(simCeloso) {
//		simCeloso.setAmigos(simCeloso.amigos().filter({unSim => not simCeloso.pareja().esAmigoDe(unSim)}))
//	}
//}
