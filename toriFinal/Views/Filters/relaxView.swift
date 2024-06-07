//
//  relaxView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct relaxView: View {
    
    var geoProx: GeometryProxy
    var suggestedRelax: [ActivityRoot] = []
    
    var body: some View {
        StackedCardView(geoProx: geoProx, suggestedCategories: suggestedRelax)
    }
}

//#Preview {
//    relaxView()
//}
