// BranchLocatorViewModel.swift
// ViewModel para el Localizador de Sucursales BAMBI.
import Foundation
import Combine
import CoreLocation

class BranchLocatorViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var branches: [Branch] = []
    @Published var userLocation: CLLocationCoordinate2D? = nil
    @Published var errorMessage: String? = nil
    @Published var isLoading = false
    
    private let service = BranchService()
    private var cancellables = Set<AnyCancellable>()
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        fetchBranches()
    }
    // Carga sucursales desde JSON
    func fetchBranches() {
        isLoading = true
        service.fetchBranches()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] branches in
                self?.branches = branches
            })
            .store(in: &cancellables)
    }
    // Solicita ubicación del usuario
    func requestUserLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last?.coordinate
        locationManager.stopUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        errorMessage = error.localizedDescription
    }
}
