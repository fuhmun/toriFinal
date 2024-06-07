//
//  SmallCardSuggestion.swift
//  toriFinal
//
//  Created by Alexander Washington on 6/6/24.
//

import SwiftUI

struct SmallCardSuggestion: View {
    var activities: Activity
    var isExpanded: Bool
    
    var geoProx: GeometryProxy
    
    var body: some View {
        VStack {
            if isExpanded {
                BackSmallSuggestion(geoProx: geoProx, activityCards: activities)
            } else {
                FrontSmallSuggestion(geoProx: geoProx, activity: activities)
            }
        }
        .frame(width: isExpanded ? UIScreen.main.bounds.width : geoProx.size.width*0.9,
               height: isExpanded ? geoProx.size.height*0.9 : geoProx.size.height*0.25)
        .background(isExpanded ? CustomColor.grayBG : CustomColor.grayBG)
        .cornerRadius(isExpanded ? 0 : 10)
        .shadow(radius: isExpanded ? 0 : 10)
    }
}

//#Preview {
//    SmallCardSuggestion()
//}
