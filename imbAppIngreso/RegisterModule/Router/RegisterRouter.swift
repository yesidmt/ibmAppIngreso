//
//  RegisterRouter.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import UIKit

///  Module Router (aka: Wireframe)
class RegisterRouter: RegisterRouterProtocol {
    let view : RegisterView
    
    init(RegisterView: RegisterView) {
        self.view = RegisterView
    }
    
    /*
    func goToPostUser (user: User) {
        let postUserView = PostUserView()
        let interactor = PostUserInteractor()
        let presenter = PostUserPresenter(PostUserInteractor: interactor)
        presenter.view = postUserView
        postUserView.presenter = presenter
       
        postUserView.user.append(user)
        view.present(postUserView, animated: true)
        
       
       
    }
     */
}
