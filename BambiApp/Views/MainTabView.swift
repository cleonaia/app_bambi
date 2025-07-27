// MainTabView.swift
// Navegación principal entre módulos: Home (notificaciones/promos), Catálogo, Simulador, Calculadora, Sucursales, Pedidos, Usuario.
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
            ProductCatalogView()
                .tabItem {
                    Label("Catálogo", systemImage: "list.bullet.rectangle")
                }
            ColorSimulatorView()
                .tabItem {
                    Label("Simulador", systemImage: "paintpalette")
                }
            PaintCalculatorView()
                .tabItem {
                    Label("Calculadora", systemImage: "function")
                }
            BranchLocatorView()
                .tabItem {
                    Label("Sucursales", systemImage: "mappin.and.ellipse")
                }
            OrderView()
                .tabItem {
                    Label("Pedidos", systemImage: "cart")
                }
            UserPanelView()
                .tabItem {
                    Label("Usuario", systemImage: "person.crop.circle")
                }
        }
    }
}

#Preview {
    MainTabView()
}
