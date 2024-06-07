//
//  searchView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct searchView: View {
    
    var geoProx: GeometryProxy
    var suggestedSearch: [Activity] = []
    
    var body: some View {
        if suggestedSearch == [] {
            LoadingView()
        } else {
            StackedCardView(geoProx: geoProx, suggestedCategories: suggestedSearch)
        }
    }
}

//#Preview {
//    searchView()
//}
