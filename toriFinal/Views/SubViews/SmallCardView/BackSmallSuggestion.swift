//
//  BackSmallSuggestion.swift
//  toriFinal
//
//  Created by Fahad Munawar on 6/6/24.
//

import SwiftUI
import CoreLocation
import SDWebImageSwiftUI
import SwiftData

struct BackSmallSuggestion: View {
    var geoProx : GeometryProxy
    var activityCards: ActivityRoot
    
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
                                            
                                        }
                                        .padding(.bottom)
                                        VStack(alignment: .leading) {
                                            Text("Phone")
                                                .fontWeight(.bold)
                                            
                                        }
                                        .padding(.bottom)
                                        VStack(alignment: .leading) {
                                            Text("Website")
                                                .fontWeight(.bold)
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
//    BackSmallSuggestion()
//}
