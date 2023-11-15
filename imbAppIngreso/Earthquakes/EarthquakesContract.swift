//
//  EarthquakesContract.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import UIKit

protocol EarthquakesViewProtocol: AnyObject {
   
    func setItemsTableview(feactures:[Feature])
    func showError(message: String)
    func spinnerOn()
    func spinnerOff()
}

//MARK: Interactor -
///  Module Interactor Protocol
protocol EarthquakesInteractorProtocol {
    func searchEarthQaukes(fechaini: String, fechafin: String, completion: @escaping (Result<[Feature], EarthquakeError>) -> Void)
}

protocol EarthquakesRouterProtocol {
    func goToEarthquakesDetail(feature:Feature) 
}
