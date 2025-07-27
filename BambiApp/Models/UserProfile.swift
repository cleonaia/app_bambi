// UserProfile.swift
// Modelo para datos de usuario y preferencias.
import Foundation

struct UserProfile: Codable {
    var name: String
    var email: String
    var favoriteProjects: [String] // Nombres o IDs de proyectos
    var favoriteColors: [String] // Hex de colores
    var preferences: [String: Bool] // Ej: notificaciones, etc.
}
