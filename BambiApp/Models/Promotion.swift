// Promotion.swift
// Modelo para promociones y notificaciones.
import Foundation

struct Promotion: Identifiable, Codable {
    let id: UUID
    let title: String
    let message: String
    let date: Date
    let isRead: Bool
}
