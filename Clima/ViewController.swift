//
//  ViewController.swift
//  Clima
//
//  Created by Mac5 on 18/11/20.
//  Copyright © 2020 itmorelia. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController   {
    
    var climaManager = ClimaManager()
    var locationManager = CLLocationManager()
    

    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var ciudadLAbel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var imagenFondoClima: UIImageView!
    @IBOutlet weak var tempMaxLabel: UILabel!
    @IBOutlet weak var tempMinLabel: UILabel!
    @IBOutlet weak var estadoClimaLabel: UILabel!
    @IBOutlet weak var humedadLabel: UILabel!
    @IBOutlet weak var velocidadVientoLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        //Solicita el permiso del usuario
        locationManager.requestWhenInUseAuthorization()
        //Solicita la ubicación
        locationManager.requestLocation()
        
        climaManager.delegado = self
        
        buscarTextField.delegate = self
    }
}

//MARK:- Protocolo CCLocationManagerDelegate para la ubicación del usuario
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Se obtuvo la ubicación")
        if let ubicaciones = locations.last {
            // deteener la actualizacion de la ubicacion
            locationManager.stopUpdatingLocation()
            
            let latitud = ubicaciones.coordinate.latitude
            let longitud = ubicaciones.coordinate.longitude
            print("Latitud: \(latitud), Longitud: \(longitud)")
            //mandar llamar a la API para hacer la consulta
            climaManager.fetchClima(lat: latitud, long: longitud)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

//MARK:- Métodos para actualizar la GUI

extension ViewController: ClimaManagerDelegate {
    
    func huboError (cualError: Error){
        print(cualError.localizedDescription)
        DispatchQueue.main.async {
            if cualError.localizedDescription == "The data couldn’t be read because it is missing."{
                self.ciudadLAbel.text = "Error, escribe una ciudad real"
            }
            if cualError.localizedDescription == "Nothing to geocode" {
                self.ciudadLAbel.text = "Error del servidor"
            }
            self.temperaturaLabel.text = ""
            self.tempMaxLabel.text = ""
            self.tempMinLabel.text = ""
            self.estadoClimaLabel.text = ""
            self.humedadLabel.text = ""
            self.velocidadVientoLabel.text = ""
            
        }
    }
    
    func actualizarClima(clima: ClimaModelo) {
        print(clima.descripcionClinma)
        print(clima.temperaturaDecimal)
        
        DispatchQueue.main.async {
            self.temperaturaLabel.text = clima.temperaturaDecimal
            self.tempMaxLabel.text = "Temp Máx:\(clima.tempMaxDecimal) °C"
            self.tempMinLabel.text = "Temp Min:\(clima.tempMinDecimal) °C"
            self.ciudadLAbel.text = "\(clima.nombreCiudad)"
            self.estadoClimaLabel.text = "\(clima.descripcionClinma)"
            self.humedadLabel.text = "Humedad: \(clima.humedad)"
            self.velocidadVientoLabel.text = "Vel. viento: \(clima.velocidad) m/s"
            self.imagenFondoClima.image = UIImage(named: clima.conicionClima)
        }
    }
    
}

//MARK:- Delegados del textfield
extension ViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //ciudadLAbel.text = buscarTextField.text
        climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if buscarTextField.text != "" {
            return true
        } else {
            buscarTextField.placeholder = "Escribe 1 ciudad"
            return false
        }
    }
    
    @IBAction func BuscarButton(_ sender: UIButton) {
        //ciudadLAbel.text = buscarTextField.text
        climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
    }
    
    @IBAction func obtenerUbicacion(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}


