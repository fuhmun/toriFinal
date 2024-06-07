//
//  foodView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct foodView: View {
    
    var geoProx: GeometryProxy
    var suggestedFood: [Activity] = []
    
    var body: some View {
        if suggestedFood == [] {
            LoadingView()
        } else {
            StackedCardView(geoProx: geoProx, suggestedCategories: suggestedFood)
        }
    }
}

//#Preview {
//    foodView()
//}
