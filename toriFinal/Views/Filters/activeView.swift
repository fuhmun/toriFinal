//
//  activeView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct activeView: View {
    
    var geoProx: GeometryProxy
    var suggestedActive: [Activity] = []
    
    var body: some View {
        if suggestedActive == [] {
            LoadingView()
        } else {
            StackedCardView(geoProx: geoProx, suggestedCategories: suggestedActive)
        }
    }
}

//#Preview {
//    activeView()
//}
