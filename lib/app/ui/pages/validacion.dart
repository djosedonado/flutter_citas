

class Validacion {
  dynamic ValidacionCorreo(dynamic value) {
    if (value == "") {
      return "Campo Vacio";
    } else {
      if (value!.isEmpty == value.isEmail) {
        return "Dominio Icorrecto";
      }
    }
  }
}

/*
if (value!.isEmpty) {
            return "Campo Vacio";
          } else {
            if (texto == "Contraseña") {
              if (value.length < 6 || value.length > 11) {
                return "El rango es de 6 a 20";
              }
            }
            if (texto == "Correo") {
              if (value!.isEmpty == value.isEmail) {
                return "Dominio Icorrecto";
              }
            }
            if (texto == "Cedula") {
              if (value.length <= 5 || value.length >= 11) {
                return "El nombre es 5 a 11";
              }
            }
            if (texto == 'Telefono') {
              if (value.length != 10) {
                return "Numero Telefono Incorrecto";
              }
            }
            if (texto == 'Direccion') {
              if (value.length <= 5 || value.length >= 40) {
                return "Perro huputa esta la direccion mala";
              }
            }
            if (texto == 'Nombres' || texto == 'Apellidos') {
              if (value.length <= 3 || value.length >= 40) {
                return "Rango es de 3 a 40";
              }
            }
          }
          return null;
*/