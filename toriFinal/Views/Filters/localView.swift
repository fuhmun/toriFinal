//
//  localView.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/4/24.
//

import SwiftUI

struct localView: View {
    
    var geoProx: GeometryProxy
    var suggestedLocal: [Activity] = []
    
    var body: some View {
        if suggestedLocal == [] {
            LoadingView()
        } else {
            StackedCardView(geoProx: geoProx, suggestedCategories: suggestedLocal)
        }
    }
}

//#Preview {
//    localView()
//}
