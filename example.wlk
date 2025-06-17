class Paciente {
  var property edad
  var property fortalezaMuscular
  var property nivelDolor
  const property aparatos = []

  method disminuirDolor(cantidad) {nivelDolor = (nivelDolor - cantidad).max(0)}

  method aumentarFortalezaMuscular(cantidad) {fortalezaMuscular += cantidad}

  method usarAparato(aparato) {
    if (aparato.puedeSerUsado(self)) {
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

}


class Magneto {
  var color = "blanco"
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