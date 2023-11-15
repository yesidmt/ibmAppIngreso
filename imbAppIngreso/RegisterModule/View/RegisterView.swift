//
//  RegisterView.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation
import UIKit
class RegisterView: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var claveInput: UITextField!
    @IBOutlet weak var nombreInput: UITextField!
    @IBOutlet weak var apellidoInput: UITextField!
    
    // MARK: - Properties
    var presenter: RegisterPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func RegisterButton(_ sender: Any) {
        guard let email = emailInput.text, !email.isEmpty,
              let nombre = nombreInput.text, !nombre.isEmpty,
              let apellido = apellidoInput.text, !apellido.isEmpty,
              let clave = claveInput.text, !clave.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Todos los campos son obligatorios", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            return
        }
        presenter?.register(email: email, nombre: nombre, apellido: apellido, clave: clave)
    }
}

// MARK: - extending RegisterView to implement it's protocol
extension RegisterView: RegisterViewProtocol {
    
    func registerSucces() {
 
        let alert = UIAlertController(title: "Guardado Correctamente", message: "ok", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { _ in
            self.cleanInputs()
            self.dismiss(animated: true)
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func registerNoSucces() {
        let alert = UIAlertController(title: "Error", message: "No se pudo guardar el usuario, intente de nuevo", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func cleanInputs() {
        self.emailInput.text = ""
        self.claveInput.text = ""
        self.nombreInput.text = ""
        self.apellidoInput.text = ""
        
    }
}
