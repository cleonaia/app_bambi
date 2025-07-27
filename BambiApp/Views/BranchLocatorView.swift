// BranchLocatorView.swift
// Vista principal del Localizador de Sucursales BAMBI con MapKit y detalles.
import SwiftUI
import MapKit

struct BranchLocatorView: View {
    @StateObject private var viewModel = BranchLocatorViewModel()
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -25.2637, longitude: -57.5759),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var selectedBranch: Branch? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                // Mapa interactivo con pins de sucursales
                Map(coordinateRegion: $region, annotationItems: viewModel.branches) { branch in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: branch.latitude, longitude: branch.longitude)) {
                        Button(action: { selectedBranch = branch }) {
                            Image(systemName: "mappin.circle.fill")
                                .font(.title)
                                .foregroundColor(.red)
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .frame(height: 320)
                // Botón para geolocalización
                if viewModel.userLocation == nil {
                    Button("Mostrar mi ubicación") {
                        viewModel.requestUserLocation()
                    }
                }
                // Lista de sucursales
                List(viewModel.branches) { branch in
                    Button(action: { selectedBranch = branch }) {
                        VStack(alignment: .leading) {
                            Text(branch.name).font(.headline)
                            Text(branch.address).font(.subheadline)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }
            }
            .navigationTitle("Sucursales BAMBI")
            // Detalle de sucursal
            .sheet(item: $selectedBranch) { branch in
                BranchDetailView(branch: branch)
            }
        }
    }
}

// Vista de detalles de sucursal
struct BranchDetailView: View {
    let branch: Branch
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(branch.name).font(.title2).bold()
            Text("Dirección: \(branch.address)")
            Text("Horario: \(branch.hours)")
            HStack {
                Image(systemName: "phone.fill")
                Link(branch.whatsapp, destination: URL(string: "https://wa.me/\(branch.whatsapp.filter(\"0123456789\".contains))")!)
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    BranchLocatorView()
}
