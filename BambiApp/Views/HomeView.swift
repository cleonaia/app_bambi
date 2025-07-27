// HomeView.swift
// Pantalla principal con soporte para notificaciones y promociones.
import SwiftUI

struct HomeView: View {
    @StateObject private var notificationVM = NotificationViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Bienvenido a BAMBI Fábricas")
                    .font(.largeTitle).bold()
                // Botón para simular recepción de promoción
                Button("Simular promoción push") {
                    notificationVM.simulatePushPromotion(title: "Oferta Especial", message: "¡20% de descuento en pinturas acrílicas esta semana!")
                }
                // Lista de promociones recientes
                if !notificationVM.promotions.isEmpty {
                    List(notificationVM.promotions) { promo in
                        VStack(alignment: .leading) {
                            Text(promo.title).font(.headline)
                            Text(promo.message)
                            Text(promo.date, style: .date).font(.caption).foregroundColor(.secondary)
                        }
                        .background(promo.isRead ? Color(.systemGray6) : Color.yellow.opacity(0.2))
                        .onTapGesture {
                            notificationVM.markAsRead(promo)
                        }
                    }
                    .frame(height: 220)
                }
                Spacer()
            }
            .padding()
            .navigationTitle("Inicio")
            // Alerta de promoción push
            .alert(isPresented: $notificationVM.showAlert) {
                Alert(
                    title: Text(notificationVM.currentPromotion?.title ?? "Promoción"),
                    message: Text(notificationVM.currentPromotion?.message ?? ""),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

#Preview {
    HomeView()
}
