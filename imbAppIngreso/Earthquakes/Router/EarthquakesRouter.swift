//
//  EarthquakesRouter.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation
import UIKit

///  Module Router (aka: Wireframe)
class EarthquakesRouter: EarthquakesRouterProtocol {
    let view : EarthquakesView
    init(EarthquakesView: EarthquakesView) {
        self.view = EarthquakesView
    }
    
    func goToLogin() {
        let loginView = LoginView()
        let interactor = LoginInteractor()
        let router = LoginRouter(loginView: loginView)
        let presenter = LoginPresenter(loginInteractor: interactor, loginRouter: router)
        presenter.view = loginView
        loginView.presenter = presenter
        changeRootViewController(to: loginView)
    }
     
    func changeRootViewController(to newRootViewController: UIViewController, animated: Bool = true) {

        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene else { return }
        guard let window = windowScene.windows.first(where: { $0.isKeyWindow }) else { return }
        if animated {
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
                window.rootViewController = newRootViewController
            })
        } else {
            window.rootViewController = newRootViewController
        }
    }
    
    func goToEarthquakesDetail(feature:Feature) {
        let earthquakesDetailView = EarthquakesDetailView()
        earthquakesDetailView.feature.append(feature)
        view.present(earthquakesDetailView, animated: true, completion: nil)
    }
}
