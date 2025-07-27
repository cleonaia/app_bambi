// ProductCatalogViewModel.swift
// ViewModel para el módulo Catálogo con filtros y búsqueda.
import Foundation
import Combine

class ProductCatalogViewModel: ObservableObject {
    // Productos cargados
    @Published var allProducts: [ProductCatalog] = []
    // Productos filtrados y buscados
    @Published var filteredProducts: [ProductCatalog] = []
    // Filtros activos
    @Published var selectedColor: String? = nil
    @Published var selectedType: String? = nil
    @Published var selectedFinish: String? = nil
    // Búsqueda
    @Published var searchText: String = ""
    @Published var searchSuggestions: [String] = []
    // Estado de carga y errores
    @Published var isLoading = false
    @Published var errorMessage: String? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let service = ProductCatalogService()
    
    init() {
        fetchProducts()
        setupSearch()
    }
    
    // Carga productos desde el JSON
    func fetchProducts() {
        isLoading = true
        service.fetchProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] products in
                self?.allProducts = products
                self?.applyFiltersAndSearch()
            })
            .store(in: &cancellables)
    }
    
    // Aplica filtros y búsqueda
    func applyFiltersAndSearch() {
        var result = allProducts
        if let color = selectedColor {
            result = result.filter { $0.colorOptions.contains(color) }
        }
        if let type = selectedType {
            result = result.filter { $0.type == type }
        }
        if let finish = selectedFinish {
            result = result.filter { $0.finish == finish }
        }
        if !searchText.isEmpty {
            result = result.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
        filteredProducts = result
    }
    
    // Configura autocompletado de búsqueda
    private func setupSearch() {
        $searchText
            .debounce(for: .milliseconds(200), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.searchSuggestions = []
                } else {
                    self.searchSuggestions = self.allProducts
                        .map { $0.name }
                        .filter { $0.localizedCaseInsensitiveContains(text) }
                        .prefix(5)
                        .map { $0 }
                }
                self.applyFiltersAndSearch()
            }
            .store(in: &cancellables)
    }
    
    // Métodos para actualizar filtros
    func setColor(_ color: String?) {
        selectedColor = color
        applyFiltersAndSearch()
    }
    func setType(_ type: String?) {
        selectedType = type
        applyFiltersAndSearch()
    }
    func setFinish(_ finish: String?) {
        selectedFinish = finish
        applyFiltersAndSearch()
    }
    func clearFilters() {
        selectedColor = nil
        selectedType = nil
        selectedFinish = nil
        applyFiltersAndSearch()
    }
}
