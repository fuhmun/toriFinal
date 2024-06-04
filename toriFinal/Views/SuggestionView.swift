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
    
    @State private var selectedCategory: yelpCategories? = nil
    
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
                            activeView()
                        } else if selectedCategory == .arts {
                            leisureView()
                        } else if selectedCategory == .beauty {
                            relaxView()
                        } else if selectedCategory == .food {
                            foodView()
                        } else if selectedCategory == .nightLife {
                            nightView()
                        } else if selectedCategory == .localFlavor {
                            localView()
                        } else {
                            searchView()
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


