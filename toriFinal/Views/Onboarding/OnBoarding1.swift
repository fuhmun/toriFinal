//
//  OnBoarding.swift
//  tori
//
//  Created by Fahad Munawar on 5/14/24.
//

import Foundation
import SwiftUI

struct OnBoarding1: View {
    @State var firstName: String = ""
    @State var lastName: String = ""
    var geometry: GeometryProxy
    let indexRectangle: Int = 0
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
            Text("Hey there! Welcome to Tori. We're excited to see what you'll explore!")
                .font(.system(.title2, design: .serif))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundColor(.white)
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
                                .fill(Color.black)
                                .opacity(0.8)
                                .frame(width: geometry.size.width / 13, height: geometry.size.height / 90)
                        }
                    }
                }
                Text("First things first, what's your name?")
                    .font(.system(.title2, design: .serif))
                    .font(.title)
                    .foregroundColor(.black)
                    .padding(.all)
                    .multilineTextAlignment(.center)
                
                TextField (
                    "First",
                    text: $firstName
                )
                .foregroundColor(.black)
                .background(Color.white)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .frame(width: geometry.size.width/1.4, height: geometry.size.height/35)
                .opacity(0.9)
                .padding(.all)
                
                TextField (
                    "Last",
                    text: $lastName
                )
                .foregroundColor(.black)
                .background(Color.white)
                .multilineTextAlignment(.center)
                .disableAutocorrection(true)
                .textFieldStyle(.roundedBorder)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .frame(width: geometry.size.width/1.4, height: geometry.size.height/35)
                .opacity(0.9)
                .padding(.all)
                Spacer()
                
                Button {
                    if firstName != "" && lastName != "" {
                        initiateDelayedActions()
                    }
                } label: {
                    Text("Next")
                        .font(.system(.title, design: .serif))
                        .foregroundStyle(Color.white)
                        .frame(width: geometry.size.width/1.3, height: geometry.size.height/11)
                        .background(RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                            .fill(firstName != "" && lastName != "" ? Color.blue : Color.gray))
                }
                
                .buttonStyle(ScaleButtonStyle())
                .padding(.bottom)
                
            }
            .padding(.top)
            .frame(width: geometry.size.width/1.2, height: geometry.size.height/1.2)
            .background(Color.white)
            .opacity(0.6)
            .clipShape(
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
            )
        }
    }
    private func initiateDelayedActions() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                if self.firstName != "" && self.lastName != "" {
                    self.selectedTab = 1
                }
            }
        }
    }
}


struct ScaleButtonStyle : ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.6 : 1.0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}

struct DefaultButtonStyle : ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
    }
}

//#Preview {
//    OnBoarding1(geometry: geometry)
//}
