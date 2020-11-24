//
//  ViewController.swift
//  Clima
//
//  Created by Mac5 on 18/11/20.
//  Copyright © 2020 itmorelia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, ClimaManagerDelegate {
    
    func huboError (cualError: Error){
        print(cualError.localizedDescription)
        DispatchQueue.main.async {
            self.ciudadLAbel.text = cualError.localizedDescription            
        }
    }
    
    func actualizarClima(clima: ClimaModelo) {
        print(clima.descripcionClinma)
        print(clima.temperaturaDecimal)
        
        DispatchQueue.main.async {
            self.temperaturaLabel.text = clima.temperaturaDecimal
            self.ciudadLAbel.text = clima.descripcionClinma
            self.imagenFondoClima.image = UIImage(named: clima.conicionClima)
        }
    }
    
    
    var climaManager = ClimaManager()
    

    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var ciudadLAbel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    @IBOutlet weak var imagenFondoClima: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        climaManager.delegado = self
        buscarTextField.delegate = self
        
    }
    
    
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
    
}

