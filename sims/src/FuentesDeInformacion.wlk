class FuentesDeInformacion {
	
	var informacion
	
	constructor(unaColeccion) {
		informacion = unaColeccion
	}
	
	method darInformacion() {
		return informacion.anyOne()
	}
	
	method informacion() {
		return informacion
	}
}

object lunaDePluton inherits FuentesDeInformacion(["Mi libro", "luna de pluton", "ya esta disponible", "en todas las librerias"]) {}
object tinelli inherits FuentesDeInformacion(["Totó"]) {}
object rial inherits FuentesDeInformacion(["Escandalo"]) {}