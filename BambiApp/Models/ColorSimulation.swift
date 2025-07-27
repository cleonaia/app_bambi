// ColorSimulation.swift
// Modelo para simulación de color sobre imágenes o AR.
import Foundation
import SwiftUI

struct ColorSimulation {
    var selectedImage: UIImage?
    var selectedZone: CGRect? // Zona seleccionada en la imagen
    var selectedColor: Color = .white // Color BAMBI aplicado
}
