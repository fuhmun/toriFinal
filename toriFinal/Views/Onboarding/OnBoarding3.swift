//
//  OnBoarding3.swift
//  tori
//
//  Created by Fahad Munawar on 5/24/24.
//

import Foundation
import SwiftUI
import SwiftData

struct MoneyOption {
    var amount: String
    var selected: Bool
}

struct OnBoarding3: View {
    @State var geometry: GeometryProxy
    let indexRectangle: Int = 2
    @Binding var selectedTab: Int
    @State var moneySelected: Bool = false
    @State private var priceSelected: String? = nil
    
    @State var money: [[MoneyOption]] = [
        [MoneyOption(amount: "$", selected: false), MoneyOption(amount: "$$", selected: false)],
        [MoneyOption(amount: "$$$", selected: false), MoneyOption(amount: "$$$$", selected: false)]
    ]
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    selectedTab = 1
                } label: {
                    Image(systemName: "arrow.left.circle.fill")
                        .resizable()
                        .frame(width: geometry.size.width * 0.13, height: geometry.size.height * 0.07)
                        .foregroundColor(Color.gray)
                        .padding(.leading)
                }
                Spacer()
            }
            .padding()
            VStack {
                HStack {
                    ForEach(0..<6) { i in
                        if indexRectangle >= i {
                            Rectangle()
                                .fill(Color.orange)
                                .frame(width: geometry.size.width / 13, height: geometry.size.height / 90)
                        }
                        else {
                            Rectangle()
                                .fill(Color.white)
                                .opacity(0.8)
                                .frame(width: geometry.size.width / 13, height: geometry.size.height / 90)
                        }
                    }
                }
                Text("What's your budget vibe?")
                    .font(.system(.title, design: .serif))
                    .font(.title)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.all)
                
                ForEach(0..<money.count, id: \.self) { rowIndex in
                    HStack (spacing: 20) {
                        ForEach(0..<money[rowIndex].count, id: \.self) { columnIndex in
                            Button(action: {
                                moneySelected = true
                                money[rowIndex][columnIndex].selected.toggle()
                                priceSelected = money[rowIndex][columnIndex].amount
                                userProfile.first?.priceLimit = money[rowIndex][columnIndex].amount
                            }) {
                                Text(money[rowIndex][columnIndex].amount)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 25)
                                        .fill(priceSelected ==  money[rowIndex][columnIndex].amount ? Color.blue : Color.white))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
                
                Button(action: {
                    if moneySelected {
                        initiateDelayedActions()
                    }
                }, label: {
                    Text("Next")
                        .font(.system(.title, design: .serif))
                        .foregroundStyle(Color.white)
                        .frame(width: geometry.size.width/2.2, height: geometry.size.height/11)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                        .background(RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(moneySelected ? Color.blue : Color.red))
                })
                .buttonStyle(ScaleButtonStyle())
                .padding(.bottom, geometry.size.height * 0.05)
            }
            .padding(.top)
//            .frame(width: geometry.size.width/1.2, height: geometry.size.height/1.2)
//            .background(Color.white)
//            .opacity(0.6)
//            .clipShape(
//                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
//            )
            Spacer()
        }
    }
    private func initiateDelayedActions() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                if moneySelected {
                    self.selectedTab = 3
                }
            }
        }
    }
}


//#Preview {
//    OnBoarding3()
//}
