//
//  ContentView.swift
//  Tori pages
//
//  Created by Leon Singleton on 5/26/24.
//

import SwiftUI
import SwiftData

struct VisitedView: View {
    @State private var selectedCardIndex: Int? = nil
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    @Binding var selectedTab: Int
    
    
    //    @Environment(\.modelContext) var modelContext
    //    @Query var visited: [ActivityRoot]
    
    var geoProx: GeometryProxy
    
    var body: some View {
        ZStack {
            if let profile = userProfile.first, !profile.visited.isEmpty {
                ForEach(0..<profile.visited.count, id: \.self) { index in
                    createCardView(for: index)
                }
            } else {
                VStack {
                    Spacer()
                    VStack {
                        Text("Show me my suggestions!")
                            .font(.system(.title2, design: .serif))
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        Button(action: {
                            selectedTab = 0
                        }) {
                            Text("Lets Go!")
                                .font(.system(.title, design: .serif))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.accentColor)
                                .cornerRadius(20)
                        }
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
    
    @ViewBuilder
    func createCardView(for index: Int) -> some View {
        if let profile = userProfile.first {
            SmallCardView(activities: profile.visited[index], isExpanded: self.selectedCardIndex == index, geoProx: geoProx)
                .offset(y: self.selectedCardIndex == index ? 0 : CGFloat(index) * 60)
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
    
}



//#Preview {
//    VisitedView()
//}
