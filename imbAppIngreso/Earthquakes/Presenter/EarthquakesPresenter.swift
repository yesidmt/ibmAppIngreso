//
//  EarthquakesPresenter.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import UIKit

class EarthquakesPresenter {
    
    weak var view: EarthquakesViewProtocol?
    private var interactor: EarthquakesInteractorProtocol
    private var router: EarthquakesRouter
    
    init(EarthquakesInteractor: EarthquakesInteractor, EarthquakesRouter: EarthquakesRouter) {
        self.interactor = EarthquakesInteractor
        self.router = EarthquakesRouter
    }

    func searchEarthQaukes(fechaini: String, fechafin: String) {
        view?.spinnerOn()
        let fechaIniSend = fechaini.replacingOccurrences(of: "/", with: "-")
        let fechaFinSend = fechafin.replacingOccurrences(of: "/", with: "-")
        interactor.searchEarthQaukes(fechaini: fechaIniSend, fechafin: fechaFinSend) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [self] in
                self.view?.spinnerOff()
                switch result {
                case .success(let features):
                    self.view?.setItemsTableview(feactures: features)
                case .failure(let error):
                    self.handleSearchError(error)
                }
            }
        }
    }

    private func handleSearchError(_ error: EarthquakeError) {
        let errorMessage: String
        switch error {
        case .invalidURL, .noData:
            errorMessage = "Error: Datos no disponibles."
        case .networkError:
            errorMessage = "Error: Problema de red."
        case .decodingError:
            errorMessage = "Error: Datos incorrectos."
        case .httpResponseError(let statusCode):
            errorMessage = "Error: Problema con el servidor (\(statusCode))."
        }
        self.view?.showError(message: errorMessage)
    }

    func goToLogin() {
        router.goToLogin()
    }

    func goToEarthquakesDetail(feature: Feature) {
        router.goToEarthquakesDetail(feature: feature)
    }
}
