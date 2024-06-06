//
//  FrontSmallCardView.swift
//  tori
//
//  Created by Fahad Munawar on 5/14/24.
//

import Foundation
import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import SwiftData

struct FrontSmallCardView: View {
    
    var geoProx: GeometryProxy
    var activity: ActivityRoot
    var test: Tag { Tag(name: activity.activity.name ?? "", price: activity.activity.price, categories: activity.activity.categories?.first?.title) }
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    var body: some View {
        
        if let imageUrl = activity.activity.image_url {
            
            AnimatedImage(url: URL(string: imageUrl))
                .resizable()
                .frame(width: geoProx.size.width*0.9, height: geoProx.size.height*0.3)
                .overlay(
                    VStack {
                        HStack {
                            TagListView(tags: [test], geoProx: geoProx)
                                .padding(.leading, geoProx.size.width*0.2)
                                .frame(width: geoProx.size.width*0.8)
                            Button {
                                deleteActivityFromMustTry()
                            } label: {
                                Image(systemName: "trash")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: geoProx.size.width*0.05, height: geoProx.size.height*0.05)
                            }
                        }
                        Spacer()
                    }
                    ,alignment: .topLeading
                )
        }
    }
        
    
    private func deleteActivityFromMustTry() {
        guard let user = userProfile.first else { return }
        
        if let index = user.mustTrys.firstIndex(where: {$0.activity.name == activity.activity.name}) {
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
}

//#Preview {
//    FrontSmallCardView()
//}
