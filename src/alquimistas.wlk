object alquimista {
  var itemsDeCombate = []
  var itemsDeRecoleccion = []
  method tieneCriterio() {
    return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadDeItemsDeCombate() / 2
  }
  
  method cantidadDeItemsDeCombate() {
    return itemsDeCombate.size()
  }
  
  method cantidadDeItemsDeCombateEfectivos() {
    return itemsDeCombate.count({ itemDeCombate =>
      itemDeCombate.esEfectivo()
    })
  }
  method cantidadDeItemsDeRecoleccion(){
  	    return itemsDeRecoleccion.size()
  	
  }
  method esBuenExplorador(){
  	return self.cantidadDeItemsDeRecoleccion() > 3
  }
  method capacidadOfensiva(){
  	return itemsDeCombate.sum({
  		item =>
  		item.capacidad()
  	})
  }
}

object bomba {
  var danio = 15
  
  method esEfectivo() {
    return danio > 100
  }
  method capacidad(){
  	return danio/2
  }
}

object pocion {
  var materiales = []
  var poderCurativo = 0
  
  method esEfectivo() {
    return poderCurativo > 50 and self.fueCreadaConAlgunMaterialMistico()
  }
  
  method fueCreadaConAlgunMaterialMistico() {
    return materiales.any({ material =>
      material.esMistico()
    })
  }
  method capacidad(){
  	return poderCurativo + 10*self.cantidadDeMaterialesMisticos()
  }
  method cantidadDeMaterialesMisticos(){
  	return materiales.count({
  		material =>
  		material.esMistico()
  	})
  }
}

object debilitador {
  var materiales = []
  var potencia = 0
  
  method esEfectivo() {
    return potencia > 0 and self.fueCreadoPorAlgunMaterialMistico().negate()
  }
  
  method fueCreadoPorAlgunMaterialMistico() {
    return materiales.any({ material =>
      material.esMistico()
    })
  }
  method capacidad(){
  	if(self.fueCreadoPorAlgunMaterialMistico()){
  		return 12*self.cantidadDeMaterialesMisticos()
  	}
  	return 5
  }
  method cantidadDeMaterialesMisticos(){
  	return materiales.count({
  		material =>
  		material.esMistico()
  	})
  }

}