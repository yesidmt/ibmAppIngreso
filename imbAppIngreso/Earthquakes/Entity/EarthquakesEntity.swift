//
//  EarthquakesEntity.swift
//  imbAppIngreso
//
//  Created by yesid mendoza on 14/11/23.
//

import Foundation


import Foundation

// Definición de la estructura principal que contiene todas las partes del JSON
struct FeatureCollection: Codable {
    let type: String
    let metadata: Metadata
    let features: [Feature]
    let bbox: [Double]
}

// Estructura para la sección "metadata"
struct Metadata: Codable {
    let generated: Int
    let url: String
    let title: String
    let status: Int
    let api: String
    let count: Int
}

// Estructura para cada elemento en la lista "features"
struct Feature: Codable {
    let type: String
    let properties: Properties
    let geometry: Geometry
    let id: String
}

// Estructura para "properties" dentro de cada "Feature"
struct Properties: Codable {
    let mag: Double?
    let place: String?
    let time: Int
    let updated: Int
    let tz: Int?
    let url: String
    let detail: String
    let felt: Int?
    let cdi: Double?
    let mmi: Double?
    let alert: String?
    let status: String
    let tsunami: Int
    let sig: Int
    let net: String
    let code: String
    let ids: String
    let sources: String
    let types: String
    let nst: Int?
    let dmin: Double?
    let rms: Double
    let gap: Double?
    let magType: String
    let title: String
}

// Estructura para "geometry"
struct Geometry: Codable {
    let type: String
    let coordinates: [Double]
}
