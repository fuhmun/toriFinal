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
                    FilterView(selectedCategory: $selectedCategory)
                        .frame(width: geoProx.size.width*0.85)
                    Spacer(minLength: geoProx.size.height*0.03)
                    ScrollView {
                        Spacer()
//                        StackedCardView(geoProx: geoProx)
                        if selectedCategory == .activeLife {
                            activeView(geoProx: geoProx)
                        } else if selectedCategory == .arts {
                            leisureView(geoProx: geoProx)
                        } else if selectedCategory == .beauty {
                            relaxView(geoProx: geoProx)
                        } else if selectedCategory == .food {
                            foodView(geoProx: geoProx)
                        } else if selectedCategory == .nightLife {
                            nightView(geoProx: geoProx)
                        } else if selectedCategory == .localFlavor {
                            localView(geoProx: geoProx)
                        } else {
                            searchView(geoProx: geoProx)
                        }
                        Spacer()
                    }
                }
                .foregroundStyle(.white)
                // alex sucks at coding
            }
        }
    }
}

#Preview {
    SuggestionView()
}


