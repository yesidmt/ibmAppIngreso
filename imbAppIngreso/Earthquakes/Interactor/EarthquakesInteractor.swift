//
//  EarthquakesInteractor.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation
import UIKit
import CoreData
import CryptoKit

class EarthquakesInteractor: EarthquakesInteractorProtocol {
  
    func searchEarthQaukes(fechaini: String, fechafin: String, completion: @escaping (Result<[Feature], EarthquakeError>) -> Void) {
        let link = "https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=\(fechaini)&endtime=\(fechafin)"
        guard let url = URL(string: link) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let dataResult = data else {
                completion(.failure(.noData))
                return
                
            }
            do {
                let feactures = try JSONDecoder().decode(FeatureCollection.self, from: dataResult)
                completion(.success(feactures.features))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }).resume()
    }    
}


/// Errores personalizados para la solicitud de terremotos
enum EarthquakeError: Error {
    case invalidURL
    case noData
    case networkError(Error)
    case decodingError(Error)
    case httpResponseError(Int)
}
