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
    @ObservedObject private var suggestedActive = YelpAPI()
    @ObservedObject private var suggestedLeisure = YelpAPI()
    @ObservedObject private var suggestedRelax = YelpAPI()
    @ObservedObject private var suggestedFood = YelpAPI()
    @ObservedObject private var suggestedLocal = YelpAPI()
    @ObservedObject private var suggestedNight = YelpAPI()
    @ObservedObject private var suggestedSearch = YelpAPI()
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    @State private var hasAppeared: Bool = false
    
//    @State var searchText: String
    
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
                            activeView(geoProx: geoProx, suggestedActive: suggestedActive.foundActivities)
                        } else if selectedCategory == .arts {
                            leisureView(geoProx: geoProx, suggestedLeisure: suggestedLeisure.foundActivities)
                        } else if selectedCategory == .beauty {
                            relaxView(geoProx: geoProx, suggestedRelax: suggestedRelax.foundActivities)
                        } else if selectedCategory == .food {
                            foodView(geoProx: geoProx, suggestedFood: suggestedFood.foundActivities)
                        } else if selectedCategory == .nightLife {
                            nightView(geoProx: geoProx, suggestedNight: suggestedNight.foundActivities)
                        } else if selectedCategory == .localFlavor {
                            localView(geoProx: geoProx, suggestedLocal: suggestedLocal.foundActivities)
                        } else {
                            searchView(geoProx: geoProx,suggestedSearch: suggestedSearch.foundActivities)
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
        .onAppear {
            if !hasAppeared {
                fetchActivities(for: .food)
                hasAppeared = true
            }
        }
    }
    
    func fetchActivities(for category: yelpCategories?) {
        guard let category = category else { return }
        
        let yelpAPI: YelpAPI
        
        switch category {
        case .activeLife:
            yelpAPI = suggestedActive
        case .arts:
            yelpAPI = suggestedLeisure
        case .beauty:
            yelpAPI = suggestedRelax
        case .food:
            yelpAPI = suggestedFood
        case .nightLife:
            yelpAPI = suggestedNight
        case .localFlavor:
            yelpAPI = suggestedLocal
        default:
            yelpAPI = suggestedSearch
        }
        
        Task {
            
            let topThree: [String] = userProfile.first?.likedCategories.getTopThree(for: category.rawValue) ?? []
            
            guard !topThree.isEmpty else {
                print("No categories found for \(category.rawValue)")
                return
            }
            
            if let randomCategory = topThree.randomElement() {
                await yelpAPI.retrieveSuggestions(cat: [randomCategory], lim: 3, sort: "distance", rad: 40000, list: RandomCategory())
                DispatchQueue.main.async {
                    print("Fetched \(yelpAPI.foundActivities.count) activities for category \(category.rawValue)")
                    // No need to map to ActivityRoot here since we're using YelpAPI instances directly
                }
            } else {
                await yelpAPI.retrieveBusiness(cat: [topThree[0]], lim: 3, sort: "distance", rad: 40000, list: RandomCategory())
                DispatchQueue.main.async {
                    print("Fetched \(yelpAPI.foundActivities.count) activities for category \(category.rawValue)")
                    // No need to map to ActivityRoot here since we're using YelpAPI instances directly
                }
            }
        }
    }
    
}

//#Preview {
//    SuggestionView()
//}


