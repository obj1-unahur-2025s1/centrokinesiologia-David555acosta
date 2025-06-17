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
  var color = "blanco"
  method color() = color 
  method puedeSerUsado(paciente) = true
  var puntos = 0
  method puntos() = puntos

  method tratamiento(paciente) {
    paciente.disminuirDolor(paciente * 0.10)
    puntos += 1
  } 
}


class Bicicleta {
  var color = "blanco"
  method puedeSerUsado(paciente) = paciente.edad() > 8
  var puntos = 0
  method puntos() = puntos

  method tratamiento(paciente) {
    paciente.disminuirDolor(4)
    paciente.aumentarFortalezaMuscular(3)
    puntos += 1
  } 
}


class Minitramp {
  var color = "blanco"
  method puedeSerUsado(paciente) = paciente.nivelDolor() < 20
  var puntos = 0
  method puntos() = puntos

  method tratamiento(paciente) {
    paciente.aumentarFortalezaMuscular(paciente.edad() * 0.10)
    puntos += 0
  } 
}

object centro {
  const property aparatosDelCentro = []
  const property pacientesTotales = []

  method aparatosSinRepetidos() = aparatosDelCentro.asList().map({a => a.color()})
  method pacientesMenoresA8Años() = pacientesTotales.asList().filter({a => a.edad() < 8 })
  method cantidadPacientesQueNoCumplenSesion() = pacientesTotales.count({ p => not p.puedeUsarTodosLosAparartos()})  
}