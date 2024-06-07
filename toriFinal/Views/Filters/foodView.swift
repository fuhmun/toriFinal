//
//  foodView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct foodView: View {
    
    var geoProx: GeometryProxy
    var suggestedFood: [ActivityRoot] = []
    
    var body: some View {
        StackedCardView(geoProx: geoProx, suggestedCategories: suggestedFood)
    }
}

//#Preview {
//    foodView()
//}
