//
//  cardView.swift
//  Tori pages
//
//  Created by Leon Singleton on 5/26/24.
//
import SwiftUI

struct SmallCardView: View {
    
    var activities: ActivityRoot
    var isExpanded: Bool
    
    var geoProx: GeometryProxy

    var body: some View {
        VStack {
            if isExpanded {
                BackSmallCardView(geoProx: geoProx, activityCards: activities)
            } else {
                FrontSmallCardView(geoProx: geoProx, activity: activities)
            }
        }
        .frame(width: isExpanded ? UIScreen.main.bounds.width : geoProx.size.width*0.9,
               height: isExpanded ? geoProx.size.height*0.9 : geoProx.size.height*0.3)
        .background(isExpanded ? CustomColor.grayBG : CustomColor.grayBG)
        .cornerRadius(isExpanded ? 0 : 10)
        .shadow(radius: isExpanded ? 0 : 10)
    }
}



//#Preview {
//    SmallCardView()
//}
