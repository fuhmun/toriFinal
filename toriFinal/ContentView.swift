//
//  ContentView.swift
//  DreamTeam
//
//  Created by Fahad Munawar on 5/3/24.
//

import Foundation
import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    @State private var selectedTab = 0
    
    init() {
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = CustomColor.grayUI
        
        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor.systemGray
        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray]
        
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor.accent
                tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.accent]
        
        UITabBar.appearance().standardAppearance = tabBarAppearance
                if #available(iOS 15.0, *) {
                    UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                }
    }
    
    var body: some View {
        TabView(selection: $selectedTab) {
            SuggestionView()
                .tabItem{
                    Label("Suggestions",systemImage:"wand.and.stars")
                }
                .tag(0)
            DiscoverView(selectedTab: $selectedTab)
                .tabItem{
                    Label("Discover",systemImage:"plus.magnifyingglass")
                }
                .tag(1)
            ProfileView(selectedTab: $selectedTab)
                .tabItem{
                    Label("Profile",systemImage:"person.fill")
                }
                .tag(2)
        }
        .onAppear {
            Task {
                initializeUserProfile()
            }
        }
    }
    
    private func initializeUserProfile() {
            if userProfile.isEmpty {
                let newUserProfile = Profile()
                modelContext.insert(newUserProfile)
                do {
                    try modelContext.save()
                    print("User profile created and saved.")
                } catch {
                    print("Failed to save the user profile: \(error)")
                }
            } else {
                print("User profile already exists.")
            }
        }
}

#Preview {
    ContentView()
}
