//
//  leisureView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct leisureView: View {
    
    var geoProx: GeometryProxy
    var suggestedLeisure: [Activity] = []
    
    var body: some View {
        if suggestedLeisure == [] {
            LoadingView()
        } else {
            StackedCardView(geoProx: geoProx, suggestedCategories: suggestedLeisure)
        }
    }
}

//#Preview {
//    leisureView()
//}
