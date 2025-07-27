// ProductCatalogService.swift
// Servicio para cargar productos desde un archivo JSON local.
import Foundation
import Combine

class ProductCatalogService {
    func fetchProducts() -> AnyPublisher<[ProductCatalog], Error> {
        Future { promise in
            guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
                promise(.failure(NSError(domain: "Archivo JSON no encontrado", code: 404)))
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let products = try JSONDecoder().decode([ProductCatalog].self, from: data)
                promise(.success(products))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
