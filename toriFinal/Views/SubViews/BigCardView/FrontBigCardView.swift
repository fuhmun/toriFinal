//
//  FrontCardView.swift
//  tori
//
//  Created by Fahad Munawar on 5/14/24.
//

import Foundation
import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import SwiftData


struct FrontBigCardView: View {
    
    var geoProx : GeometryProxy
    var activityCards: Activity
    @ObservedObject var randomActivity: YelpAPI
    var activityList: RandomCategory
    @Binding var dragOffset: CGSize
    var swipeAction: (() -> Void)?
    
    @State private var isFavorite: Bool = false
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    var body: some View {
        
        if let imageUrl = activityCards.image_url {
            AnimatedImage(url: URL(string: imageUrl))
                .resizable()
                .frame(width: geoProx.size.width/1.25, height: geoProx.size.height/1.25)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .top, endPoint: .center)
                )
                .overlay(
                    VStack {
                        HStack {
                            VStack(alignment: .leading) {
                                if let name = activityCards.name {
                                    Text(name)
                                        .font(.title3)
                                }
                                if let city = activityCards.location?.city, let state = activityCards.location?.state {
                                    Text("\(city), \(state)")
                                }
                                if !activityCards.categoryTitles.isEmpty {
                                    Text(activityCards.categoryTitles)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                            }
                            
                            .foregroundStyle(.white)
                            Spacer()
                            Button {
                                isFavorite.toggle()
                                if isFavorite {
                                    addActivityToMustTrys()
                                } else {
                                    deleteActivityFromMustTry()
                                }
                            } label: {
                                Image(systemName: isFavorite ? "heart.fill" : "heart")
                                    .foregroundStyle(.white)
                            }
                        }
                        .padding(geoProx.size.height/30)
                        Spacer()
                        HStack {
                            Button {
                                dragOffset = CGSize(width: -500, height: 0)
                                swipeAction?()
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(.accent)
                                        .frame(width: geoProx.size.width*0.13)
                                    Image(systemName: "xmark")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                }
                            }
                            Spacer()
                            Button {
                                dragOffset = CGSize(width: 500, height: 0)
                                swipeAction?()
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(.accent)
                                        .frame(width: geoProx.size.width*0.13)
                                    Image(systemName: "checkmark")
                                        .font(.largeTitle)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding(geoProx.size.height/30)
                    }
                    ,alignment: .topLeading
                )
                .onAppear {
                    checkIfFavorite()
                }
        }
    }
    
    func addActivityToMustTrys() {
        
        guard let user = userProfile.first else {
            print("No user profile found")
            return
        }
        
        let mustTryActivity = ActivityRoot(id: UUID(), activity: swiftActivity(from: activityCards))
        
        user.mustTrys.append(mustTryActivity)
        modelContext.insert(mustTryActivity)
        
        do {
            try modelContext.save()
            isFavorite = true
            print("Activity added to mustTrys")
        } catch {
            print("Failed to save context: \(error)")
        }
        
        if let profile = userProfile.first {
            print("User profile mustTrys count: \(profile.mustTrys.count)")
            for activity in profile.mustTrys {
                print("Activity name: \(activity.activity.name ?? "Unknown")")
            }
        }
    }
    
    private func deleteActivityFromMustTry() {
        guard let user = userProfile.first else { return }
        
        if let index = user.mustTrys.firstIndex(where: {$0.activity.name == activityCards.name}) {
            let activityToRemove = user.mustTrys.remove(at: index)
            modelContext.delete(activityToRemove)
            
            do {
                try modelContext.save()
                print("Activity removed from mustTrys")
            } catch {
                print("Failed to save context: \(error)")
            }
        }
        
        if let profile = userProfile.first {
            print("User profile mustTrys count: \(profile.mustTrys.count)")
            for activity in profile.mustTrys {
                print("Activity name: \(activity.activity.name ?? "Unknown")")
            }
        }
    }
    
    func checkIfFavorite() {
        guard let profile = userProfile.first else { return }
        isFavorite = profile.mustTrys.contains(where: {$0.activity.name == activityCards.name})
    }
}

//#Preview {
//    FrontBigCardView()
//}
