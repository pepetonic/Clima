//
//  ClimaManager.swift
//  Clima
//
//  Created by Mac5 on 21/11/20.
//  Copyright © 2020 itmorelia. All rights reserved.
//

import Foundation

protocol ClimaManagerDelegate {
    func actualizarClima(clima: ClimaModelo)
    
    func huboError (cualError: Error)
}

struct ClimaManager {
    
    var delegado: ClimaManagerDelegate?
    
    let url = "https://api.openweathermap.org/data/2.5/weather?appid=c4c7d06ede28fa79c1a9f80406088e68&units=metric&lang=es"
    
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
                    self.delegado?.huboError(cualError: error!)
                    return
                }
                
                if let datosSeguros = data {
                    //Decodoficar el OBJ JSON de la API
                    if let clima = self.parseJSON(climaData: datosSeguros){
                        //Quien sea el delegado cualquier clase o struct que implemente el metodo de actualizar clima
                        self.delegado?.actualizarClima(clima: clima)
                    }
                }
            }
            
            //4.- Empezar tarea
            tarea.resume()
            
        }
        
    }
    
    func parseJSON (climaData: Data) -> ClimaModelo?{
        let decoder = JSONDecoder()
        do{
            let dataDecodificada = try decoder.decode(ClimaData.self, from: climaData)
            let id = dataDecodificada.weather[0].id
            let nombre = dataDecodificada.name
            let descripcion = dataDecodificada.weather[0].description
            let tempeatura = dataDecodificada.main.temp
            
            let ObjClima = ClimaModelo(condicionID: id, nombreCiudad: nombre, descripcionClinma: descripcion, temperaturaCelcius: tempeatura)
            
            return ObjClima
        } catch {
            delegado?.huboError(cualError: error)
            return nil
        }
    }
}
