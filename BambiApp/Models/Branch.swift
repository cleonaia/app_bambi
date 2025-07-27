// Branch.swift
// Modelo para sucursales BAMBI.
import Foundation
import CoreLocation

struct Branch: Identifiable, Codable {
    let id: Int
    let name: String
    let address: String
    let latitude: Double
    let longitude: Double
    let hours: String
    let whatsapp: String
}
