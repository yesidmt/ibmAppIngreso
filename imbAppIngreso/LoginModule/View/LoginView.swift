//
//  LoginView.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation
import UIKit
class LoginView: UIViewController {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var emailInput: UITextField!
    @IBOutlet weak var claveInput: UITextField!
    @IBOutlet weak var loginCardContent: UIView!
    
    // MARK: - Properties
    var presenter: LoginPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailInput.text, !email.isEmpty,
              let clave = claveInput.text, !clave.isEmpty else {
            let alert = UIAlertController(title: "Error", message: "Todos los campos son obligatorios", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
            return
        }
        presenter?.login(email: email, clave: clave)
    }
    func setupViews() {
        self.loginCardContent.layer.cornerRadius = 5
        self.loginCardContent.layer.borderWidth = 0.2
        self.loginCardContent.layer.borderColor = UIColor.gray.cgColor
        self.loginCardContent.layer.shadowColor = UIColor.gray.cgColor
        self.loginCardContent.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.loginCardContent.layer.shadowRadius = 9.0
        self.loginCardContent.layer.shadowOpacity = 4.5
    }
    @IBAction func register(_ sender: Any) {
        presenter?.goToRegister()
    }
}
// MARK: - extending LoginView to implement it's protocol
extension LoginView: LoginViewProtocol {
    func loginSucces() {
        presenter?.goToEarthquakesView()
    }
    
    func loginError() {
        let alert = UIAlertController(title: "Error", message: "No se pudo iniciar sesion, verifica los datos y vuelve a intentar", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}
