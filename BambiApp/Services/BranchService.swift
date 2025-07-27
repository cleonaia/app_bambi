// BranchService.swift
// Servicio para cargar sucursales desde un JSON local.
import Foundation
import Combine

class BranchService {
    func fetchBranches() -> AnyPublisher<[Branch], Error> {
        Future { promise in
            guard let url = Bundle.main.url(forResource: "branches", withExtension: "json") else {
                promise(.failure(NSError(domain: "Archivo JSON no encontrado", code: 404)))
                return
            }
            do {
                let data = try Data(contentsOf: url)
                let branches = try JSONDecoder().decode([Branch].self, from: data)
                promise(.success(branches))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}
