//
//  leisureView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct leisureView: View {
    
    var geoProx: GeometryProxy
    var suggestedLeisure: [ActivityRoot] = []
    
    var body: some View {
        StackedCardView(geoProx: geoProx, suggestedCategories: suggestedLeisure)
    }
}

//#Preview {
//    leisureView()
//}
