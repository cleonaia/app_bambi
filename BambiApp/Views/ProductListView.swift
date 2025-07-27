// ProductListView.swift
// Vista principal para mostrar el catálogo de productos BAMBI.
import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel = ProductListViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Cargando productos...")
                } else if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                } else {
                    List(viewModel.products) { product in
                        HStack {
                            Image(product.imageUrl)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            VStack(alignment: .leading) {
                                Text(product.name).font(.headline)
                                Text(product.description).font(.subheadline).foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Catálogo BAMBI")
        }
        .onAppear { viewModel.fetchProducts() }
    }
}

#Preview {
    ProductListView()
}
