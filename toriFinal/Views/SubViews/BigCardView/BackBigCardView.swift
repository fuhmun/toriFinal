//
//  BackCardView.swift
//  tori
//
//  Created by Fahad Munawar on 5/14/24.
//

import Foundation
import SwiftUI
import SwiftData
import SDWebImageSwiftUI

struct BackBigCardView: View {
    
    var geoProx : GeometryProxy
    var activityCards: Activity
    @ObservedObject var randomActivity: YelpAPI
    
    var body: some View {
        VStack {
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
                                    if let distance = activityCards.distance {
                                        let miles = distance * 0.000621371
                                        Text(String(format: "%.2f mi", miles))
                                    }
                                }
                                .foregroundStyle(.white)
                                Spacer()
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
                                            if let address = activityCards.location?.address1, let city = activityCards.location?.city, let state = activityCards.location?.state {
                                                    Text("\(address), \(city), \(state)")
                                                        .font(.subheadline)
                                                }
                                            
                                        }
                                        .padding(.bottom)
                                        VStack(alignment: .leading) {
                                            Text("Phone")
                                                .fontWeight(.bold)
                                            if activityCards.display_phone == "" {
                                                Text("Not available")
                                                    .font(.subheadline)
                                            }
                                            else {
                                                Button {
                                                    let tel = "tel://"
                                                    let formattedString = tel + activityCards.display_phone!
                                                    guard let url = URL(string: formattedString) else { return }
                                                    UIApplication.shared.open(url)
                                                } label: {
                                                    Text(activityCards.display_phone!)
                                                        .font(.subheadline)
                                                }
                                            }
//                                            Text(activityCards.display_phone ?? "Not available")
//                                                    .font(.subheadline)
                                        }
                                        .padding(.bottom)
                                        VStack(alignment: .leading) {
                                            Text("Website")
                                                .fontWeight(.bold)
                                            Text(activityCards.business_url ?? "Not available")
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
}

//#Preview {
//    BackBigCardView()
//}
