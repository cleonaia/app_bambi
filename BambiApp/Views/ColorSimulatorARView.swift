// ColorSimulatorARView.swift
// Vista ARKit simple para simular color sobre una pared usando la cámara.
import SwiftUI
import ARKit
import RealityKit

struct ColorSimulatorARView: UIViewRepresentable {
    let selectedColor: Color
    
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        // Configuración básica de AR
        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal, .vertical]
        arView.session.run(config)
        // Agrega un plano virtual con el color seleccionado
        let planeMesh = MeshResource.generatePlane(width: 0.5, depth: 0.5)
        let color = UIColor(selectedColor)
        let material = SimpleMaterial(color: color.withAlphaComponent(0.7), isMetallic: false)
        let entity = ModelEntity(mesh: planeMesh, materials: [material])
        let anchor = AnchorEntity(plane: .vertical)
        anchor.addChild(entity)
        arView.scene.addAnchor(anchor)
        return arView
    }
    func updateUIView(_ uiView: ARView, context: Context) {
        // Actualiza color si cambia
    }
}

// Extensión para convertir Color a UIColor
extension UIColor {
    convenience init(_ color: Color) {
        let scanner = Scanner(string: color.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        if scanner.scanHexInt64(&hexNumber) {
            let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
            let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
            let b = CGFloat(hexNumber & 0x0000ff) / 255
            self.init(red: r, green: g, blue: b, alpha: 1)
            return
        }
        self.init(red: 1, green: 1, blue: 1, alpha: 1)
    }
}
