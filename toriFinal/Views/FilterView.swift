//
//  FilterView.swift
//  tori
//
//  Created by Fahad Munawar on 5/14/24.
//

import Foundation
import SwiftUI
import SwiftData

struct FilterView: View {
    
    @Binding var selectedCategory: yelpCategories?
    var geoProx: GeometryProxy
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(yelpCategories.allCases, id: \.self) { category in
                    Button {
                        if selectedCategory == category {
                            selectedCategory = nil
                        } else {
                            selectedCategory = category
                        }
                        userProfile.first?.likedCategories.getTopThree(for: category.rawValue)
                        print(category.rawValue)
                        print(selectedCategory ?? "")
                    } label: {
                        VStack {
                            Image(systemName: category.icon)
                            Text(category.rawValue)
                                .font(.caption)
                        }
                        .foregroundStyle(selectedCategory == category ? .accent : .white)
                    }
                    .frame(width: geoProx.size.width * 0.125)
                    .disabled (
                        selectedCategory == category
                    )
                }
            }
        }
    }
}

//#Preview {
//    FilterView()
//}
