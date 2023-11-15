//
//  LoginContract.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func loginSucces()
    func loginError()
}

//MARK: Interactor -
///  Module Interactor Protocol
protocol LoginInteractorProtocol {
    func login(email: String, clave: String) -> Bool
}

protocol LoginRouterProtocol {
  //  func loginSucces ()
    func goToRegister()
}
