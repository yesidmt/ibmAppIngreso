//
//  EarthquakesDetailView.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 15/11/23.
//

import Foundation
import UIKit
import GoogleMaps

class EarthquakesDetailView: UIViewController {
    
    @IBOutlet weak var viewContentCard: UIView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var magnitud: UILabel!
    @IBOutlet weak var profundidad: UILabel!
    @IBOutlet weak var lugar: UILabel!
    @IBOutlet weak var mapViewContent: UIView!
    
    var feature: [Feature] = []
    var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    func setupView() {
        guard feature.count > 0 else { return }
        titulo.text = feature[0].properties.title
        magnitud.text = "Magnitud: \(String(feature[0].properties.mag ?? 0))"
        profundidad.text = "Profundidad: \(String(feature[0].properties.nst ?? 0))"
        lugar.text = feature[0].properties.place

        let  lat = feature[0].geometry.coordinates[1]
        let long = feature[0].geometry.coordinates[0]
        setupMap(lat: lat, long: long)
        
        //setupCard
        
        self.viewContentCard.layer.borderWidth = 0.2
        self.viewContentCard.layer.borderColor = UIColor.gray.cgColor
        self.viewContentCard.layer.shadowColor = UIColor.gray.cgColor
        self.viewContentCard.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.viewContentCard.layer.shadowRadius = 4.0
        self.viewContentCard.layer.shadowOpacity = 0.3
        
    }
    
    func setupMap(lat: Double, long: Double) {
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: long, zoom: 9.0)
        mapView = GMSMapView(frame: self.mapViewContent.bounds)
        mapView.camera = camera
        mapView.settings.zoomGestures = true
        mapView.settings.setAllGesturesEnabled(true)

        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
        marker.title = feature[0].properties.place
        marker.snippet = feature[0].properties.title
        marker.map = mapView

        self.mapViewContent.addSubview(mapView)
    }
    
}

