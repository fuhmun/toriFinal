//
//  SplashScreen.swift
//  tori
//
//  Created by Fahad Munawar on 5/14/24.
//

import SwiftUI
import SwiftData

struct SplashScreenView: View {
    
    @State private var onScreen: Bool = false
    @State private var toriBlink: Bool = false
    @State private var imageOpacity: Double = 0.0
    
    @Environment(\.modelContext) var modelContext
    @Query var userProfile: [Profile]
    
    var body: some View {
        ZStack {
            if self.onScreen {
                if userProfile.first?.didOnboarding == false {
                    OnBoarding()
                } else {
                    ContentView()
                }
            } else {
                Image("Background")
                    .resizable()
                    .ignoresSafeArea()
                    .scaledToFill()
                
                GeometryReader { geometry in
                    VStack {
                        Image("Tori")
                            .resizable()
                            .scaledToFit()
                        
                            .frame(width: geometry.size.width / 2.5)
                        
                    }
                    .opacity(imageOpacity)
                    .animation(Animation.easeInOut(duration: 0.7).repeatForever(autoreverses: true), value: toriBlink)
                    .position(x: geometry.frame(in: .local).midX, y: geometry.size.height / 3)
                    .animation(.easeInOut(duration: 4.5), value: imageOpacity)
                }
            }
        }
        .onAppear() {
            toriBlink = true
            withAnimation {
                imageOpacity = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    self.onScreen = true
                }
            }
        }
    }
}


#Preview {
    SplashScreenView()
}
