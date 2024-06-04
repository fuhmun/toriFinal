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
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 27) {
                ForEach(yelpCategories.allCases, id: \.self) { category in
                    Button {
                        if selectedCategory == category {
                            selectedCategory = nil
                        } else {
                            selectedCategory = category
                        }
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
