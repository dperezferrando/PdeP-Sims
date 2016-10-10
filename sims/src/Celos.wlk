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
