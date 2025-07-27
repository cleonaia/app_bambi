// UserProfileViewModel.swift
// ViewModel para panel de usuario y preferencias.
import Foundation
import Combine

class UserProfileViewModel: ObservableObject {
    @Published var profile: UserProfile = UserProfile(name: "", email: "", favoriteProjects: [], favoriteColors: [], preferences: [:])
    @Published var errorMessage: String? = nil
    
    private let profileKey = "userprofile_bambi"
    
    init() {
        loadProfile()
    }
    func updateProfile(name: String, email: String) {
        profile.name = name
        profile.email = email
        saveProfile()
    }
    func addFavoriteProject(_ project: String) {
        if !profile.favoriteProjects.contains(project) {
            profile.favoriteProjects.append(project)
            saveProfile()
        }
    }
    func removeFavoriteProject(_ project: String) {
        profile.favoriteProjects.removeAll { $0 == project }
        saveProfile()
    }
    func addFavoriteColor(_ color: String) {
        if !profile.favoriteColors.contains(color) {
            profile.favoriteColors.append(color)
            saveProfile()
        }
    }
    func removeFavoriteColor(_ color: String) {
        profile.favoriteColors.removeAll { $0 == color }
        saveProfile()
    }
    func setPreference(_ key: String, value: Bool) {
        profile.preferences[key] = value
        saveProfile()
    }
    // UserDefaults: guardar/cargar
    private func saveProfile() {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: profileKey)
        }
    }
    private func loadProfile() {
        if let data = UserDefaults.standard.data(forKey: profileKey),
           let saved = try? JSONDecoder().decode(UserProfile.self, from: data) {
            profile = saved
        }
    }
}
