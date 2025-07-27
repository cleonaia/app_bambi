// ProductCatalog.swift
// Modelo extendido para productos con filtros y ficha técnica.
import Foundation

struct ProductCatalog: Identifiable, Codable {
    let id: Int
    let name: String
    let description: String
    let imageUrl: String
    let colorOptions: [String] // Hex o nombres de colores
    let type: String // Ej: "Acrílica", "Esmalte"
    let finish: String // Ej: "Mate", "Brillante"
    let technicalSheet: String // URL o texto
    // Agrega más campos según la API real
}
