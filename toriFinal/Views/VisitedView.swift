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
                    RoundedRectangle(cornerRadius: 20.0)
                        .fill(.white.opacity(0.75))
                        .frame(width: geoProx.size.width*0.75, height: geoProx.size.height*0.6)
                        .overlay (
                            VStack {
                                Spacer()
                                Image("Group")
                                    .resizable()
                                    .frame(width: geoProx.size.width*0.6, height: geoProx.size.height*0.25)
//                                    .frame(width: geoProx.size.width * 0.6, height: geoProx.size.height * 0.4)
                                
                                Text("Let's find some cool spots to add.")
                                    .font(.system(.title2, design: .serif))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .padding(.top, 20)
                                
                                Button(action: {
                                    // Button action
                                }) {
                                    Text("Get Started!")
                                        .font(.system(.title, design: .serif))
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.accentColor)
                                        .cornerRadius(20)
                                }
                                .frame(width: geoProx.size.width * 0.6, height: geoProx.size.height * 0.08)
                                .padding(.top, 20)
                                Spacer()
                            }
                            , alignment: .center)
                }
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
