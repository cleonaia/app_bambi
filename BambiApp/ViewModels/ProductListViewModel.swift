// ProductListViewModel.swift
// ViewModel para manejar la lógica de la lista de productos.
import Foundation
import Combine

class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let productService = ProductService()
    
    func fetchProducts() {
        isLoading = true
        productService.fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            }, receiveValue: { products in
                self.products = products
            })
            .store(in: &cancellables)
    }
}
