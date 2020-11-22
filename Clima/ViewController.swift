//
//  ViewController.swift
//  Clima
//
//  Created by Mac5 on 18/11/20.
//  Copyright © 2020 itmorelia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let climaManager = ClimaManager()
    

    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var buscarTextField: UITextField!
    @IBOutlet weak var ciudadLAbel: UILabel!
    @IBOutlet weak var climaImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        buscarTextField.delegate = self
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ciudadLAbel.text = buscarTextField.text
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
        ciudadLAbel.text = buscarTextField.text
        climaManager.fetchClima(nombreCiudad: buscarTextField.text!)
    }
    
}

