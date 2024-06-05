//
//  ContentView.swift
//  Tori pages
//
//  Created by Leon Singleton on 5/26/24.
//

import SwiftUI
import SwiftData

struct MustTryView: View {
    
    @State private var selectedCardIndex: Int? = nil
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]

    var geoProx: GeometryProxy
    
//    @State var mustTryCards: [ActivityRoot] = []
    
    var body: some View {
        ZStack {
            if let profile = userProfile.first, !profile.mustTrys.isEmpty {
                ForEach(0..<profile.mustTrys.count, id: \.self) { index in
                    createCardView(for: index)
                }
                .onDelete(perform: deleteActivity)
            } else {
                VStack {
                    Spacer()
//                    Text("None")
                        .foregroundStyle(.white)
                    Spacer()
                }
                .frame(width: geoProx.size.width*0.7, height: geoProx.size.height*0.7)
            }
        }
        .edgesIgnoringSafeArea(.all)
//        .onAppear {
//            updateMustTryCards()
//        }
//        .onChange(of: userProfile.first?.mustTrys) {
//            updateMustTryCards()
//        }
    }
    
    @ViewBuilder
    func createCardView(for index: Int) -> some View {
        if let profile = userProfile.first, index < profile.mustTrys.count {
            SmallCardView(activities: profile.mustTrys[index], isExpanded: self.selectedCardIndex == index, geoProx: geoProx)
                .offset(y: self.selectedCardIndex == index ? 0 : CGFloat(index) * 100)
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
    
    func deleteActivity(_ indexSet: IndexSet) {
        guard let profile = userProfile.first  else { return }
            
        for index in indexSet {
            let activity = profile.mustTrys[index]
            modelContext.delete(activity)
        }
         
        do {
            try modelContext.save()
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
//    func updateMustTryCards() {
//        mustTryCards = userProfile.first?.mustTrys ?? []
//    }
}

//#Preview {
//    MustTryView()
//}

