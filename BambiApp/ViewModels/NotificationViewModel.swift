// NotificationViewModel.swift
// ViewModel para notificaciones push y promociones.
import Foundation
import Combine

class NotificationViewModel: ObservableObject {
    @Published var promotions: [Promotion] = []
    @Published var showAlert: Bool = false
    @Published var currentPromotion: Promotion? = nil
    
    private let promotionsKey = "promotions_bambi"
    
    init() {
        loadPromotions()
    }
    // Simula recepción de una notificación push
    func simulatePushPromotion(title: String, message: String) {
        let promo = Promotion(id: UUID(), title: title, message: message, date: Date(), isRead: false)
        promotions.insert(promo, at: 0)
        currentPromotion = promo
        showAlert = true
        savePromotions()
    }
    // Marca promoción como leída
    func markAsRead(_ promo: Promotion) {
        if let idx = promotions.firstIndex(where: { $0.id == promo.id }) {
            promotions[idx].isRead = true
            savePromotions()
        }
    }
    // UserDefaults: guardar/cargar
    private func savePromotions() {
        if let data = try? JSONEncoder().encode(promotions) {
            UserDefaults.standard.set(data, forKey: promotionsKey)
        }
    }
    private func loadPromotions() {
        if let data = UserDefaults.standard.data(forKey: promotionsKey),
           let saved = try? JSONDecoder().decode([Promotion].self, from: data) {
            promotions = saved
        }
    }
    // Lógica para conectar con backend/Firebase (placeholder)
    func registerForPushNotifications() {
        // Aquí se integraría con APNs o Firebase Messaging
    }
    func handleRemoteNotification(_ userInfo: [AnyHashable: Any]) {
        // Aquí se procesaría la notificación recibida
    }
}
