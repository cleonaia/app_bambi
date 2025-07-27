// PaintCalculatorViewModel.swift
// ViewModel para la Calculadora de Pintura BAMBI.
import Foundation
import Combine

class PaintCalculatorViewModel: ObservableObject {
    @Published var area: String = ""
    @Published var selectedSurface: String = "Pared Interior"
    @Published var calculationResult: PaintCalculationResult? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    // Superficies y rendimiento (m2/litro)
    let surfaces = [
        "Pared Interior": 10.0,
        "Pared Exterior": 8.0,
        "Madera": 12.0,
        "Metal": 14.0
    ]
    // Productos ejemplo (en real, cargar del catálogo)
    let products: [ProductCatalog] = [
        ProductCatalog(id: 1, name: "Pintura Acrílica BAMBI", description: "Para interiores.", imageUrl: "product1", colorOptions: ["#FF0000"], type: "Acrílica", finish: "Mate", technicalSheet: ""),
        ProductCatalog(id: 2, name: "Esmalte Sintético BAMBI", description: "Para metal/madera.", imageUrl: "product2", colorOptions: ["#0000FF"], type: "Esmalte", finish: "Brillante", technicalSheet: "")
    ]
    // Precios simulados (por litro)
    let prices: [Int: Double] = [1: 35000, 2: 42000]
    
    // Función de cálculo principal
    func calculate() {
        guard let areaValue = Double(area), areaValue > 0 else {
            errorMessage = "Ingresa un valor válido de metros cuadrados."
            calculationResult = nil
            return
        }
        isLoading = true
        errorMessage = nil
        // Selecciona producto recomendado según superficie
        let product: ProductCatalog
        switch selectedSurface {
        case "Pared Interior":
            product = products[0]
        case "Pared Exterior":
            product = products[0]
        case "Madera", "Metal":
            product = products[1]
        default:
            product = products[0]
        }
        // Calcula litros necesarios
        let rendimiento = surfaces[selectedSurface] ?? 10.0
        let litros = (areaValue / rendimiento).rounded(.up)
        // Calcula precio estimado
        let precio = (prices[product.id] ?? 0) * litros
        calculationResult = PaintCalculationResult(recommendedProduct: product, litersNeeded: litros, estimatedPrice: precio)
        isLoading = false
    }
}
