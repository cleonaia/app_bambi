// ColorSimulatorViewModel.swift
// ViewModel para la lógica del Simulador de Color.
import Foundation
import SwiftUI
import Combine

class ColorSimulatorViewModel: ObservableObject {
    @Published var simulation = ColorSimulation()
    @Published var showImagePicker = false
    @Published var showARView = false
    @Published var availableColors: [Color] = [BrandColors.primary, BrandColors.secondary, BrandColors.accent]
    @Published var errorMessage: String? = nil
    
    // Selecciona imagen desde galería o cámara
    func selectImage(_ image: UIImage) {
        simulation.selectedImage = image
    }
    // Selecciona zona a pintar (mock: toda la imagen o un rect)
    func selectZone(_ rect: CGRect) {
        simulation.selectedZone = rect
    }
    // Aplica color BAMBI
    func applyColor(_ color: Color) {
        simulation.selectedColor = color
    }
    // Inicia modo AR
    func startAR() {
        showARView = true
    }
    // Lógica de ARKit se maneja en la vista AR
}
