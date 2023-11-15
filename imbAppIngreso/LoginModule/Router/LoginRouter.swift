//
//  LoginRouter.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import UIKit

///  Module Router (aka: Wireframe)
class LoginRouter: LoginRouterProtocol {
    let view : LoginView
    let viewRegister = RegisterView()
    init(loginView: LoginView) {
        self.view = loginView
    }
    
    func goToRegister() {
        let interactor = RegisterInteractor()
        _ = RegisterRouter(RegisterView: viewRegister)
        let presenter = RegisterPresenter(RegisterInteractor: interactor)
        presenter.view = viewRegister
        viewRegister.presenter = presenter
        
        view.present(viewRegister, animated: true)
        
    }
    
    func goToEarthquakesView() {
        let earthquakesView = EarthquakesView()
        let interactor = EarthquakesInteractor()
        let router = EarthquakesRouter(EarthquakesView: earthquakesView)
        let presenter = EarthquakesPresenter(EarthquakesInteractor: interactor, EarthquakesRouter: router)
        presenter.view = earthquakesView
        earthquakesView.presenter = presenter
       
        earthquakesView.modalPresentationStyle = .fullScreen 
        view.present(earthquakesView, animated: true, completion: nil)
    }
     
}
