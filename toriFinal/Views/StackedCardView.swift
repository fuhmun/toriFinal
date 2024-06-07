//
//  StackedCardView.swift
//  tori
//
//  Created by Alexander Washington on 5/28/24.
//

import SwiftUI

struct StackedCardView: View {

    @State private var selectedCardIndex: Int? = nil
    
    var geoProx: GeometryProxy
    var suggestedCategories: [ActivityRoot]
    
    var body: some View {
        ZStack {
            ForEach(0..<suggestedCategories.count, id: \.self) { index in
                createStackedView(for: index)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    func createStackedView(for index: Int) -> some View {
        SmallCardView(activities: suggestedCategories[index], isExpanded: self.selectedCardIndex == index, geoProx: geoProx)
            .offset(y: self.selectedCardIndex == index ? 0 : CGFloat(index) * geoProx.size.height*0.275)
            .rotation3DEffect(
                .degrees(self.selectedCardIndex == index ? 180 : 0),
                axis: (x: 0, y: 2, z: 0)
            )
            .animation(.spring(), value: self.selectedCardIndex == index)
            .onTapGesture {
                withAnimation {
                    if self.selectedCardIndex == index {
                        self.selectedCardIndex = nil
                    } else {
                        self.selectedCardIndex = index
                    }
                }
            }
            .zIndex(self.selectedCardIndex == index ? 1 : 0)
    }
    
}

//#Preview {
//    StackedCardView()
//}
