//
//  FactoryApp.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation
import UIKit

class FactoryApp {
    // MARK: - Properties
    let view = LoginView()
   
    func createAppInit(windows:UIWindow){
        if isUserLoggedIn() {
            // Dirige al usuario a la pantalla principal
  
            let earthquakesView = EarthquakesView()
            let interactor = EarthquakesInteractor()
            let router = EarthquakesRouter(EarthquakesView: earthquakesView)
            let presenter = EarthquakesPresenter(EarthquakesInteractor: interactor, EarthquakesRouter: router)
            earthquakesView.presenter = presenter
            presenter.view = earthquakesView
           
            windows.rootViewController = earthquakesView
            windows.makeKeyAndVisible()
            
        
        } else {
            // Muestra la pantalla de inicio de sesión
            let interactor = LoginInteractor()
            let router = LoginRouter(loginView: view)
            let presenter = LoginPresenter(loginInteractor: interactor, loginRouter: router)
            presenter.view = view
            view.presenter = presenter
            windows.rootViewController = view
            windows.makeKeyAndVisible()
        }
    }
    // Verificar el estado de la sesión
    private func isUserLoggedIn() -> Bool {
        return UserDefaults.standard.bool(forKey: "isLoggedIn")
    }
}
