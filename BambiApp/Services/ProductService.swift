// ProductService.swift
// Servicio para obtener productos desde la web de BAMBI (ejemplo con datos mock).
import Foundation
import Combine

class ProductService {
    func fetchProducts() -> AnyPublisher<[Product], Error> {
        // Reemplaza con llamada real a la API
        let mockProducts = [
            Product(id: 1, name: "Pintura Acrílica", description: "Ideal para interiores.", imageUrl: "product1", colorOptions: ["#FF0000", "#FFFF00"]),
            Product(id: 2, name: "Esmalte Sintético", description: "Acabado brillante.", imageUrl: "product2", colorOptions: ["#0000FF", "#00FF00"])
        ]
        return Just(mockProducts)
            .setFailureType(to: Error.self)
            .delay(for: .seconds(1), scheduler: DispatchQueue.global())
            .eraseToAnyPublisher()
    }
}
