//
//  searchView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct searchView: View {
    
    var geoProx: GeometryProxy
    var suggestedSearch: [ActivityRoot] = []
    
    var body: some View {
        StackedCardView(geoProx: geoProx, suggestedCategories: suggestedSearch)
    }
}

//#Preview {
//    searchView()
//}
