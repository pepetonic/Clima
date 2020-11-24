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
            return "tormenta-1.jpg"
        case 300...321:
            return "lluvia.jpg"
        case 600...622:
            return "nevado.jpg"
        case 800:
            return "despejado.jpg"
        case 801...804:
            return "nubes.jpeg"
        default:
            return "despejado.jpg"
        }
    }
    
    var temperaturaDecimal: String {
        return String(format: "%.1f", temperaturaCelcius)
    }
}
