// OrderViewModel.swift
// ViewModel para gestión de pedidos y carrito.
import Foundation
import Combine

class OrderViewModel: ObservableObject {
    @Published var cart: [OrderItem] = []
    @Published var orders: [Order] = []
    @Published var errorMessage: String? = nil
    
    private let ordersKey = "orders_bambi"
    private let cartKey = "cart_bambi"
    
    init() {
        loadCart()
        loadOrders()
    }
    // Agrega producto al carrito
    func addToCart(product: ProductCatalog, quantity: Int) {
        if let index = cart.firstIndex(where: { $0.product.id == product.id }) {
            cart[index].quantity += quantity
        } else {
            cart.append(OrderItem(id: UUID(), product: product, quantity: quantity))
        }
        saveCart()
    }
    // Elimina producto del carrito
    func removeFromCart(item: OrderItem) {
        cart.removeAll { $0.id == item.id }
        saveCart()
    }
    // Realiza pedido
    func placeOrder() {
        guard !cart.isEmpty else { errorMessage = "El carrito está vacío"; return }
        let order = Order(id: UUID(), date: Date(), items: cart, status: "Pendiente")
        orders.insert(order, at: 0)
        cart.removeAll()
        saveOrders()
        saveCart()
    }
    // Cambia estado de pedido (simulado)
    func updateOrderStatus(order: Order, status: String) {
        if let idx = orders.firstIndex(where: { $0.id == order.id }) {
            orders[idx].status = status
            saveOrders()
        }
    }
    // UserDefaults: guardar/cargar
    private func saveCart() {
        if let data = try? JSONEncoder().encode(cart) {
            UserDefaults.standard.set(data, forKey: cartKey)
        }
    }
    private func loadCart() {
        if let data = UserDefaults.standard.data(forKey: cartKey),
           let saved = try? JSONDecoder().decode([OrderItem].self, from: data) {
            cart = saved
        }
    }
    private func saveOrders() {
        if let data = try? JSONEncoder().encode(orders) {
            UserDefaults.standard.set(data, forKey: ordersKey)
        }
    }
    private func loadOrders() {
        if let data = UserDefaults.standard.data(forKey: ordersKey),
           let saved = try? JSONDecoder().decode([Order].self, from: data) {
            orders = saved
        }
    }
}
