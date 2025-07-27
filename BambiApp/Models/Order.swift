// Order.swift
// Modelo para pedidos y carrito.
import Foundation

struct Order: Identifiable, Codable {
    let id: UUID
    let date: Date
    let items: [OrderItem]
    let status: String // Ej: "Pendiente", "Enviado", "Entregado"
}

struct OrderItem: Identifiable, Codable {
    let id: UUID
    let product: ProductCatalog
    let quantity: Int
}
