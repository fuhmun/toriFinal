//
//  nightView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct nightView: View {
    
    var geoProx: GeometryProxy
    var suggestedNight: [ActivityRoot] = []
    
    var body: some View {
        StackedCardView(geoProx: geoProx, suggestedCategories: suggestedNight)
    }
}

//#Preview {
//    nightView()
//}
