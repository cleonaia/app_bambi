// Product.swift
// Modelo de datos para productos de pintura BAMBI.
import Foundation

struct Product: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: String
    let colorOptions: [String] // Hex o nombres de colores
    // Agrega más campos según la API
}
