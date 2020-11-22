//
//  ClimaModelo.swift
//  Clima
//
//  Created by Mac5 on 21/11/20.
//  Copyright © 2020 itmorelia. All rights reserved.
//

import Foundation

struct ClimaModelo{
    let condicionID: Int
    let nombreCiudad: String
    let descripcionClinma: String
    let temperaturaCelcius: Double

    //Crear propiedad computada
    
    var conicionClima: String {
        switch condicionID {
        case 200...232:
            return "tormenta"
        case 701...781:
            return "lluvioso"
        case 800:
            return "soleado"
        default:
            return "mapa"
        }
    }
    
    var temperaturaDecimal: String {
        return String(format: "%.1f", temperaturaCelcius)
    }
}
