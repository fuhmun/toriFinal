//
//  localView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct localView: View {
    
    var geoProx: GeometryProxy
    var suggestedLocal: [ActivityRoot] = []
    
    var body: some View {
        StackedCardView(geoProx: geoProx, suggestedCategories: suggestedLocal)
    }
}

//#Preview {
//    localView()
//}
