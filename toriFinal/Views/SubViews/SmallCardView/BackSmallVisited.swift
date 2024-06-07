//
//  BackSmallVisited.swift
//  toriFinal
//
//  Created by Alexander Washington on 6/7/24.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import SwiftData

struct BackSmallVisited: View {
    
    var geoProx : GeometryProxy
    var activityCards: ActivityRoot
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    var body: some View {
        VStack {
            if let imageUrl = activityCards.activity.image_url {
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
                                    if let name = activityCards.activity.name {
                                        Text(name)
                                            .font(.title3)
                                    }
                                    if let city = activityCards.activity.location?.city, let state = activityCards.activity.location?.state {
                                        Text("\(city), \(state)")
                                    }
                                    if let distance = activityCards.activity.distance {
                                        let miles = distance * 0.000621371
                                        Text(String(format: "%.2f mi", miles))
                                    }
                                }
                                .foregroundStyle(.white)
                                Spacer()
                                Button {
                                    deleteActivityFromVisited()
                                } label: {
                                    Image(systemName: "trash")
                                        .resizable()
                                        .foregroundStyle(.red)
                                        .frame(width: geoProx.size.width*0.05, height: geoProx.size.height*0.03)
                                }
                            }
                            .padding(geoProx.size.height/30)
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(.white.opacity(0.75))
                                .frame(width: geoProx.size.width*0.7, height: geoProx.size.height*0.55)
                                .overlay (
                                    VStack(alignment: .leading) {
                                        VStack(alignment: .leading) {
                                            Text("Hours")
                                                .fontWeight(.bold)
                                            Text("Sunday")
                                            Text("Monday")
                                            Text("Tuesday")
                                            Text("Wednesday")
                                            Text("Thursday")
                                            Text("Friday")
                                            Text("Saturday")
                                        }
                                        .padding(.bottom)
                                        VStack(alignment: .leading) {
                                            
                                                Text("Address")
                                                    .fontWeight(.bold)
                                            if let address = activityCards.activity.location?.address1, let city = activityCards.activity.location?.city, let state = activityCards.activity.location?.state {
                                                    Text("\(address), \(city), \(state)")
                                                        .font(.subheadline)
                                                }
                                            
                                        }
                                        .padding(.bottom)
                                        VStack(alignment: .leading) {
                                            Text("Phone")
                                                .fontWeight(.bold)
                                            if let phone = activityCards.activity.display_phone {
                                                    Text("\(phone)")
                                                        .font(.subheadline)
                                                }
//                                            Text(activityCards.activity.display_phone ?? "Not available")
//                                                .font(.subheadline)
                                        }
                                        .padding(.bottom)
                                        VStack(alignment: .leading) {
                                            Text("Website")
                                                .fontWeight(.bold)
                                            Text(activityCards.activity.attributes?.business_url ?? "Not available")
                                                .font(.subheadline)
                                        }

                                    }
                                        .padding()
                                    , alignment: .leading)
                        }
                        ,alignment: .topLeading
                    )
            }
        }
        .rotation3DEffect(Angle(degrees: 180), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
    
    private func deleteActivityFromVisited() {
        guard let user = userProfile.first else { return }
        
        if let index = user.visited.firstIndex(where: {$0.activity.name == activityCards.activity.name}) {
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
}

//#Preview {
//    BackSmallVisited()
//}
