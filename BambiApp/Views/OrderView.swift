// OrderView.swift
// Vista principal para gestión de pedidos y carrito.
import SwiftUI

struct OrderView: View {
    @StateObject private var viewModel = OrderViewModel()
    @State private var showHistory = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Carrito actual
                List {
                    Section(header: Text("Carrito")) {
                        ForEach(viewModel.cart) { item in
                            HStack {
                                Text(item.product.name)
                                Spacer()
                                Text("x\(item.quantity)")
                                Button(action: { viewModel.removeFromCart(item: item) }) {
                                    Image(systemName: "trash").foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                // Botón para realizar pedido
                Button(action: { viewModel.placeOrder() }) {
                    Text("Realizar Pedido")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                // Navegar a historial
                Button("Ver historial de pedidos") {
                    showHistory = true
                }
                .sheet(isPresented: $showHistory) {
                    OrderHistoryView(viewModel: viewModel)
                }
                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }
                Spacer()
            }
            .navigationTitle("Pedidos BAMBI")
        }
    }
}

// Vista de historial de pedidos
struct OrderHistoryView: View {
    @ObservedObject var viewModel: OrderViewModel
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Historial de Pedidos")) {
                    ForEach(viewModel.orders) { order in
                        VStack(alignment: .leading) {
                            Text("Pedido: \(order.id.uuidString.prefix(8))")
                            Text("Fecha: \(order.date, formatter: dateFormatter)")
                            Text("Estado: \(order.status)")
                            ForEach(order.items) { item in
                                Text("- \(item.product.name) x\(item.quantity)")
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Historial")
        }
    }
    // Formateador de fecha
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateStyle = .short
        df.timeStyle = .short
        return df
    }
}
