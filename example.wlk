class Paciente {
  var property edad
  var property fortalezaMuscular
  var property nivelDolor
  const property aparatos = []

  method disminuirDolor(cantidad) {nivelDolor = (nivelDolor - cantidad).max(0)}

  method aumentarFortalezaMuscular(cantidad) {fortalezaMuscular += cantidad}

  method pacientePuedeUsarElAparato(aparato) = aparato.puedeSerUsado(self) 

  method usarAparato(aparato) {
    if (!self.pacientePuedeUsarElAparato(aparato)) {
      self.error("El paciente no puede usar el aparato")
    } else {
      aparato.tratamiento(self)
    }
  }

  method puedeUsarTodosLosAparartos() = aparatos.all({ a => a.puedeSerUsado(self)})
  method realizarSesionCompleta() {aparatos.forEach({ a => self.usarAparato(a)})}  
}

class Resistente inherits Paciente {
  var puntosTotales = 0
  method puntosTotales() = puntosTotales
  override method realizarSesionCompleta() {
    super()
    puntosTotales = aparatos.sum({a => a.puntos()})
  }
}

class Caprichoso inherits Paciente {
  override method usarAparato(aparato) {
    if (aparatos.any({a => a.color() == "rojo"})) {
      aparato.tratamiento(self)
      aparato.tratamiento(self)
    }
  }
}

class RapidaRecuperacion inherits Paciente {
  var property cantidadConfigurable = 3
  override method realizarSesionCompleta() {
    super()
    self.disminuirDolor(cantidadConfigurable)
  }
}


class Magneto {
  var property color = "blanco"
  var puntosDeImantacion = 800
  method puntosDeImantacion() = puntosDeImantacion 
  method color() = color 
  method puedeSerUsado(paciente) = true
  var puntos = 0
  method puntos() = puntos

  method tratamiento(paciente) {
    paciente.disminuirDolor(paciente * 0.10)
    puntos += 1
    puntosDeImantacion = (puntosDeImantacion - 1).max(0)
  }

  method necesitaMantenimiento() = puntosDeImantacion < 100
  method recibirMantenimiento() {
    if (self.necesitaMantenimiento()) {
      puntosDeImantacion =  (puntosDeImantacion + 500).min(800)
    }
  }  
}


class Bicicleta {
  var cantidadDeDesajustesDeTornillo = 0
  var cantidadPerdidasAceite = 0
  method cantidadDeDesajustesDeTornillo() = cantidadDeDesajustesDeTornillo
  method cantidadPerdidasAceite() = cantidadPerdidasAceite 
  var property color = "blanco"
  method puedeSerUsado(paciente) = paciente.edad() > 8
  var puntos = 0
  method puntos() = puntos

  method tratamiento(paciente) {
    if (paciente.nivelDolor() > 30) {
      cantidadDeDesajustesDeTornillo += 1
    }

    if (50 >= paciente.edad() >= 30 ) {
      cantidadPerdidasAceite += 1
    }
    paciente.disminuirDolor(4)
    paciente.aumentarFortalezaMuscular(3)
    puntos += 1
  }

  method necesitaMantenimiento() = cantidadDeDesajustesDeTornillo >= 10 
                                  || cantidadPerdidasAceite >=5

  method recibirMantenimiento() {
    if(self.necesitaMantenimiento()) {
      cantidadDeDesajustesDeTornillo = 0
      cantidadPerdidasAceite = 0
    }
  }
}



class Minitramp {
  var property color = "blanco"
  method puedeSerUsado(paciente) = paciente.nivelDolor() < 20
  var puntos = 0
  method puntos() = puntos

  method tratamiento(paciente) {
    paciente.aumentarFortalezaMuscular(paciente.edad() * 0.10)
    puntos += 0
  }

   method necesitaMantenimiento() = false
   method recibirMantenimiento() {}
}

object centro {
  const property aparatosDelCentro = []
  const property pacientesTotales = []

  method aparatosSinRepetidos() = aparatosDelCentro.asList().map({a => a.color()})

  method pacientesMenoresA8Años() = pacientesTotales.asList().filter({a => a.edad() < 8 })

  method cantidadPacientesQueNoCumplenSesion() = 
  pacientesTotales.count({ p => not p.puedeUsarTodosLosAparartos()})

  method estaEnOptimasCondiciones() = aparatosDelCentro.all({ a => not a.necesitaMantenimiento()})

  method cantidadDeAparatosqueNecesitanMantenimiento() = aparatosDelCentro.count({a => a.necesitaMantenimiento()})

  method estaComplicado() = self.cantidadDeAparatosqueNecesitanMantenimiento() >= aparatosDelCentro.size()

  method registrarVisitaDeTecnico() {aparatosDelCentro.forEach({a => a.recibirMantenimiento()})}   
}