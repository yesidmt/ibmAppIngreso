//
//  RegisterPresenter.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import UIKit

/// PostUserPresenter Module Presenter
class RegisterPresenter {
    
    weak var view: RegisterViewProtocol?
    private var interactor: RegisterInteractorProtocol
    
    init(RegisterInteractor: RegisterInteractor) {
        self.interactor = RegisterInteractor
    }

    func register(email:String,nombre:String,apellido:String,clave:String){
        let registerValidate = interactor.register(email: email, nombre: nombre, apellido: apellido, clave: clave)
        if registerValidate {
            view?.registerSucces()
        } else {
            view?.registerNoSucces()
        }
    }
}

