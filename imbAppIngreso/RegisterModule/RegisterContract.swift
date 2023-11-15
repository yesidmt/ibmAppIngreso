//
//  RegisterContract.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import UIKit

protocol RegisterViewProtocol: AnyObject {
    func registerSucces()
    func registerNoSucces()
}

//MARK: Interactor -
///  Module Interactor Protocol
protocol RegisterInteractorProtocol {
    func register(email: String, nombre: String, apellido: String, clave: String) -> Bool 
    
}

protocol RegisterRouterProtocol {
  //  func RegisterSucces ()
}
