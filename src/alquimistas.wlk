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
  method esProfesional(){
  	return self.calidadPromedioItems() > 50 && self.todosSusItemsDeCombateSonEfectivos() && self.esBuenExplorador()
  }
  method calidadPromedioItems(){
  	return (self.calidadDeItemsDeCombate() + self.calidadDeItemsDeRecoleccion()) / (self.cantidadDeItemsDeCombate() + self.cantidadDeItemsDeRecoleccion())
  }
  method calidadDeItemsDeCombate(){
  	return itemsDeCombate.sum({
  		item =>
  		item.calidad()
  	})
  }
  method calidadDeItemsDeRecoleccion(){
  	return itemsDeRecoleccion.sum({
  		item =>
  		item.calidad()
  	})
  }
  method todosSusItemsDeCombateSonEfectivos(){
  	return itemsDeCombate.all({
  		item =>
  		item.esEfectivo()
  	})
  }
}

object bomba {
  var danio = 15
  var materiales = []
  
  method esEfectivo() {
    return danio > 100
  }
  method capacidad(){
  	return danio/2
  }
  method calidad(){
  	materiales.min({
  		material => material.calidad()
  	})
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
  method calidad(){
  	if (self.fueCreadaConAlgunMaterialMistico()){
  		return self.primerMaterialMistico().calidad()
  	}
  	return self.primerMaterial().calidad()
  }
  method primerMaterialMistico(){
  	return materiales.filter({
  		material =>
  		material.esMistico()
  	}).first()
  }
  method primerMaterial(){
  	return materiales.first()
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
  method calidad(){
  	return self.calidadDeDosMejoresItems() / 2
  }
  method calidadDeDosMejoresItems(){
  	return materiales.sortedBy({
  		unMaterial, otroMaterial => unMaterial.calidad() > otroMaterial.calidad()
  	}).take(2).sum({
  		material => material.calidad()
  	})
  }
 
}