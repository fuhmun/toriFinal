//
//  DiscoverView.swift
//  DreamTeam
//
//  Created by Alexander Washington on 5/11/24.
//

import Foundation
import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import SwiftData

extension View {
    func cardStack(at position: Int, in total : Int) -> some View {
        let offset = Double(total - position)
        if(offset == 0) {
            return self.offset(y: 0)
        } else {
            return self.offset(y: -40)
        }
    }
    
    func cardScale(at position: Int, in total : Int) -> some View {
        let scale = Double(total - position)
        return self.scaleEffect(1.1 - scale * 0.05)
    }
    
    func cardZOffest(at position: Int, in total : Int) -> some View {
        let zOffset = Double(total - position)
        return self.zIndex(zOffset * -1)
    }
}

struct DiscoverView: View {
    
    @StateObject private var randomActivity = YelpAPI()
    @State private var activitesLoaded: Bool = false
    @State private var cardOffset: Int = 0
    @State private var activityList = RandomCategory()
    
    @Binding var selectedTab: Int
    
    var body: some View {
        GeometryReader{ geoProx in
            ZStack {
                Image("discoveryBG")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geoProx.size.width)
                    .ignoresSafeArea()
                VStack {
                    if !activitesLoaded {
                        LoadingView()
                    } else {
                        ZStack {
                            ForEach((randomActivity.foundActivities.indices), id: \.self) { card in
                                CardView(geoProx: geoProx, activityCards: randomActivity.foundActivities[card], randomActivity: randomActivity, activityList: activityList) {
                                    withAnimation {
                                        removeCard(at: card)
                                    }
                                }
                                .cardStack(at: card, in: randomActivity.foundActivities.count - 1)
                                .cardScale(at: card, in: randomActivity.foundActivities.count - 1)
                                .cardZOffest(at: card, in: randomActivity.foundActivities.count - 1)
                                .allowsHitTesting(card == randomActivity.foundActivities.count - 1)
                            }
                        }
                    }
                }
            }
            .onAppear {
                if randomActivity.foundActivities.isEmpty {
                    Task {
                        await randomActivity.retrieveBusiness(cat: [activityList.activities.randomElement() ?? "food"], lim: 10, sort: "distance", rad: 40000, list: activityList)
                    }
                }
            }
            .onReceive(randomActivity.$foundActivities) { newActivities in
                if (!newActivities.isEmpty) {
                    activitesLoaded = true
                    for i in randomActivity.foundActivities {
                        print(i.name ?? "")
                    }
                    print("New activities retrieved: \(newActivities.count)")
                } else {
                    activitesLoaded = false
                    print("No activities found.")
                }
                
            }
        }
    }
    
    func removeCard(at index: Int) {
            randomActivity.foundActivities.remove(at: index)
    }
    
}

//#Preview {
//    DiscoverView()
//}
