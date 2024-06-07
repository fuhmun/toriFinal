//
//  FrontSmallSuggestion.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/6/24.
//

import Foundation
import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import SwiftData

struct FrontSmallSuggestion: View {
    
    var geoProx: GeometryProxy
    var activity: Activity
    var test: Tag { Tag(name: activity.name ?? "", price: activity.price, categories: activity.categories?.first?.title) }
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    @State private var isFavorite: Bool = false
    
    var body: some View {
        
        if let imageUrl = activity.image_url {
            
            AnimatedImage(url: URL(string: imageUrl))
                .resizable()
                .frame(width: geoProx.size.width*0.9, height: geoProx.size.height*0.25)
                .overlay(
                    VStack {
                        HStack {
                            TagListView(tags: [test], geoProx: geoProx)
                                .padding(.leading, geoProx.size.width*0.2)
                                .frame(width: geoProx.size.width*0.8)
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
                            Spacer()
                        }
                        Spacer()
                        HStack {
                            Button {
//                                deleteActivityFromVisited()
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(.accent)
                                        .frame(width: geoProx.size.width*0.1)
                                    Image(systemName: "xmark")
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                }
                            }
                            Spacer()
                            Button {
//                                addActivityToVisited()
                            } label: {
                                ZStack {
                                    Circle()
                                        .fill(.accent)
                                        .frame(width: geoProx.size.width*0.1)
                                    Image(systemName: "checkmark")
                                        .font(.subheadline)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        .padding(geoProx.size.height/50)
                    }
                    ,alignment: .topLeading
                )
        }
    }
    
    func addActivityToMustTrys() {
        
        guard let user = userProfile.first else {
            print("No user profile found")
            return
        }
        
        let mustTryActivity = ActivityRoot(id: UUID(), activity: swiftActivity(from: activity))
        
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
        
        if let index = user.mustTrys.firstIndex(where: {$0.activity.name == activity.name}) {
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
    
    func addActivityToVisited() {
        
        guard let user = userProfile.first else {
            print("No user profile found")
            return
        }
        
        let VisitedActivity = ActivityRoot(id: UUID(), activity: swiftActivity(from: activity))
        
        user.visited.append(VisitedActivity)
        modelContext.insert(VisitedActivity)
        
        do {
            try modelContext.save()
            isFavorite = true
            print("Activity added to mustTrys")
        } catch {
            print("Failed to save context: \(error)")
        }
        
        if let profile = userProfile.first {
            print("User profile mustTrys count: \(profile.visited.count)")
            for activity in profile.visited {
                print("Activity name: \(activity.activity.name ?? "Unknown")")
            }
        }
    }
    
    private func deleteActivityFromVisited() {
        guard let user = userProfile.first else { return }
        
        if let index = user.visited.firstIndex(where: {$0.activity.name == activity.name}) {
            let activityToRemove = user.visited.remove(at: index)
            modelContext.delete(activityToRemove)
            
            do {
                try modelContext.save()
                print("Activity removed from mustTrys")
            } catch {
                print("Failed to save context: \(error)")
            }
        }
        
        if let profile = userProfile.first {
            print("User profile mustTrys count: \(profile.visited.count)")
            for activity in profile.visited {
                print("Activity name: \(activity.activity.name ?? "Unknown")")
            }
        }
    }
    
    func checkIfFavorite() {
        guard let profile = userProfile.first else { return }
        isFavorite = profile.mustTrys.contains(where: {$0.activity.name == activity.name})
    }
}

//#Preview {
//    FrontSmallSuggestion()
//}
