//
//  SuggestionView.swift
//  tori
//
//  Created by Fahad Munawar on 5/14/24.
//

import Foundation
import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import SwiftData

struct SuggestionView: View {
    
    @State private var selectedCategory: yelpCategories? = .food
    @State private var suggestedActive: [ActivityRoot] = []
    @State private var suggestedLeisure: [ActivityRoot] = []
    @State private var suggestedRelax: [ActivityRoot] = []
    @State private var suggestedFood: [ActivityRoot] = []
    @State private var suggestedLocal: [ActivityRoot] = []
    @State private var suggestedNight: [ActivityRoot] = []
    @State private var suggestedSearch: [ActivityRoot] = []
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    var body: some View {
        GeometryReader { geoProx in
            ZStack {
                Image("SuggestionBG")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geoProx.size.width)
                    .ignoresSafeArea()
                VStack {
                    SearchBarView(geoProx: geoProx, selectedCategory: $selectedCategory)
                        .padding()
                    FilterView(selectedCategory: $selectedCategory, geoProx: geoProx)
                        .frame(width: geoProx.size.width*0.85)
                    Spacer(minLength: geoProx.size.height*0.03)
                    ScrollView {
                        Spacer()
                        if selectedCategory == .activeLife {
                            activeView(geoProx: geoProx, suggestedActive: suggestedActive)
                        } else if selectedCategory == .arts {
                            leisureView(geoProx: geoProx, suggestedLeisure: suggestedLeisure)
                        } else if selectedCategory == .beauty {
                            relaxView(geoProx: geoProx, suggestedRelax: suggestedRelax)
                        } else if selectedCategory == .food {
                            foodView(geoProx: geoProx, suggestedFood: suggestedFood)
                        } else if selectedCategory == .nightLife {
                            nightView(geoProx: geoProx, suggestedNight: suggestedNight)
                        } else if selectedCategory == .localFlavor {
                            localView(geoProx: geoProx, suggestedLocal: suggestedLocal)
                        } else {
                            searchView(geoProx: geoProx,suggestedSearch: suggestedSearch)
                        }
                        Spacer()
                    }
                }
                .foregroundStyle(.white)
                // alex sucks at coding
            }
        }
        .onChange(of: selectedCategory) {
            fetchActivities(for: selectedCategory)
        }
    }
    
    func fetchActivities(for category: yelpCategories?) {
        guard let category = category else { return }
        
        let yelpAPI = YelpAPI()
        
        Task {
            
            var topThree: [String] = userProfile.first?.likedCategories.getTopThree(for: category.rawValue) ?? []
            
            guard !topThree.isEmpty else {
                        print("No categories found for \(category.rawValue)")
                        return
            }
            
            await yelpAPI.retrieveBusiness(cat: [topThree[0]], lim: 3, sort: "distance", rad: 40000, list: RandomCategory())
            DispatchQueue.main.async {
                print("Fetched \(yelpAPI.foundActivities.count) activities for category \(category.rawValue)")
                switch category {
                case .activeLife:
                    self.suggestedActive = yelpAPI.foundActivities.map { ActivityRoot(id: UUID(), activity: swiftActivity(from: $0)) }
                case .arts:
                    self.suggestedLeisure = yelpAPI.foundActivities.map { ActivityRoot(id: UUID(), activity: swiftActivity(from: $0)) }
                case .beauty:
                    self.suggestedRelax = yelpAPI.foundActivities.map { ActivityRoot(id: UUID(), activity: swiftActivity(from: $0)) }
                case .food:
                    self.suggestedFood = yelpAPI.foundActivities.map { ActivityRoot(id: UUID(), activity: swiftActivity(from: $0)) }
                case .nightLife:
                    self.suggestedNight = yelpAPI.foundActivities.map { ActivityRoot(id: UUID(), activity: swiftActivity(from: $0)) }
                case .localFlavor:
                    self.suggestedLocal = yelpAPI.foundActivities.map { ActivityRoot(id: UUID(), activity: swiftActivity(from: $0)) }
                }
                print("Updated suggested activities for \(category.rawValue)")
                print(suggestedActive)
            }
        }
    }
}

#Preview {
    SuggestionView()
}


