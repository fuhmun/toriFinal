//
//  OnBoarding2.swift
//  tori
//
//  Created by Fahad Munawar on 5/23/24.
//

import SwiftUI
import SwiftData

struct DietOption {
    var name: String
    var diet: Dietary
    var selected: Bool
}

struct OnBoarding2: View {
    @State var geometry: GeometryProxy
    let indexRectangle: Int = 1
    @Binding var selectedTab: Int
    @State var dietSelected: Bool = false
    
    @State private var selectedDiet: Dietary? = nil
    
    @State var diets: [[DietOption]] = [
        [DietOption(name: "Vegan",diet: .vegan, selected: false), DietOption(name: "Vegetarian",diet: .vegetarian, selected: false)],
        [DietOption(name: "Halal",diet: .halal, selected: false), DietOption(name: "Pescetarian",diet: .pescetarian, selected: false)],
        [DietOption(name: "Carnivore",diet: .carnivore, selected: false), DietOption(name: "None",diet: .everything, selected: false)]
    ]
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    var body: some View {
        //For the tab index at the top
        VStack {
            HStack {
                Button {
                    selectedTab = 0
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
                Text("Got any dietary preferences?")
                    .font(.system(.title, design: .serif))
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(.all)
                    .multilineTextAlignment(.center)
                
                ForEach(0..<diets.count, id: \.self) { rowIndex in
                    HStack (spacing: 20) {
                        ForEach(0..<diets[rowIndex].count, id: \.self) { columnIndex in
                            Button(action: {
                                dietSelected = true
//                                diets[rowIndex][columnIndex].selected.toggle()
                                selectedDiet = diets[rowIndex][columnIndex].diet
                                userProfile.first?.diet = diets[rowIndex][columnIndex].diet
                            }) {
                                Text(diets[rowIndex][columnIndex].name)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.black)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 25)
                                        .fill(/*diets[rowIndex][columnIndex].selected*/  selectedDiet == diets[rowIndex][columnIndex].diet ? Color.blue : Color.white))
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                Spacer()
                
                Button(action: {
                    if dietSelected {
                        initiateDelayedActions()
                    }
                }, label: {
                    Text("Next")
                        .font(.system(.title, design: .serif))
                        .foregroundStyle(Color.white)
                        .frame(width: geometry.size.width/2.2, height: geometry.size.height/11)
                        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                        .background(RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(dietSelected ? Color.blue : Color.red))
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
            
            //Flattens two dimensional array and creates a new array of strings (names)
//            let selectedDiets = diets.flatMap { $0 }
//                .filter { $0.selected }
//                .map { $0.name }
        }
    }
    private func initiateDelayedActions() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                if dietSelected {
                    self.selectedTab = 2
                    
                }
            }
        }
    }
}


//#Preview {
//    OnBoarding2()
//}
