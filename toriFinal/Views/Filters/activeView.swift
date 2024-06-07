//
//  activeView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct activeView: View {
    
    var geoProx: GeometryProxy
    var suggestedActive: [ActivityRoot] = []
    
    var body: some View {
        if suggestedActive == [] {
            Text("None")
        } else {
            StackedCardView(geoProx: geoProx, suggestedCategories: suggestedActive)
        }
    }
}

//#Preview {
//    activeView()
//}
