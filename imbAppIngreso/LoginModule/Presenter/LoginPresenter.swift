//
//  LoginPresenter.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import UIKit

/// PostUserPresenter Module Presenter
class LoginPresenter {
    
    weak var view: LoginViewProtocol?
    private var interactor: LoginInteractorProtocol
    private var router: LoginRouter
    
    init(loginInteractor: LoginInteractor,loginRouter: LoginRouter) {
        self.interactor = loginInteractor
        self.router = loginRouter
    }
    func login(email:String,clave:String){
        let isLogin = interactor.login(email: email, clave: clave)
        
        if isLogin {
            view?.loginSucces()
        } else {
            view?.loginError()
        }
    }
    func goToRegister() {
        router.goToRegister()
    }
    func goToEarthquakesView () {
        router.goToEarthquakesView()
    }
}

