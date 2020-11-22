//
//  ClimaManager.swift
//  Clima
//
//  Created by Mac5 on 21/11/20.
//  Copyright © 2020 itmorelia. All rights reserved.
//

import Foundation

struct ClimaManager {
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=c4c7d06ede28fa79c1a9f80406088e68&units=metric"
    
    func fetchClima (nombreCiudad: String){
        let urlString = "\(url)&q=\(nombreCiudad)"
        print(urlString)
        
        realizarSolicitud(urlString: urlString)
    }
    
    func realizarSolicitud(urlString: String){
        //1,- Crear la url
        if let url = URL(string: urlString){
            // 2,- Crear el obj URLsession
            let session = URLSession(configuration: .default)
            
            //3.- Asignar una tarea a la session
            //let tarea = session.dataTask(with: url, completionHandler: handle(data:respuesta:error:))
            let tarea = session.dataTask(with: url) { (data, respuesta, error) in
                if error != nil{
                    print(error)
                    return
                }
                
                if let datosSeguros = data {
                    //let dataString = String(data: datosSeguros, encoding: .utf8)
                    //print(dataString)
                    //Decodoficar el OBJ JSON de la API
                    
                }
            }
            
            //4.- Empezar tarea
            tarea.resume()
            
        }
        
    }
    
}
