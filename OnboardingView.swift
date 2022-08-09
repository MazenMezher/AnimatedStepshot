//
//  OnboardingView.swift
//  AnimatedStepshot
//
//  Created by Mazen Mezher on 2022-06-02.
//

import SwiftUI
import RiveRuntime

struct OnboardingView: View {
    let button = RiveViewModel(fileName: "button")
    @State var showHome = false
    
    var body: some View {
        ZStack {
            background
            
            VStack(alignment: .leading, spacing: 16) {
                Text("Looking for work?")
                    .font(.custom("Poppins Bold", size: 50, relativeTo: .largeTitle))
                    .frame(width: 260, alignment: .leading)
                
                Text("StepStone is one of the world's leading next generation recruitment platforms. Through our AI-powered hiring platform and smart autonomous matching technologies we aim to disrupt the way talent and all-sized businesses connect.")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                    
                
                button.view()
                    .frame(width: 236, height: 64)
                    .overlay(
                        Label("Start the search", systemImage: "arrow.forward")
                            .offset(x: 4, y: 4)
                            .font(.headline)
                    )
                    .background(
                        Color.black
                            .cornerRadius(30)
                            .blur(radius: 10)
                            .opacity(0.3)
                            .offset(y: 10)
                    )
                    .onTapGesture {
                        button.play(animationName: "active")
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
                           // Code you want to be delayed
                            showHome = true
                        }
                        
                }
                
                Text("StepShot has been helping companies make great hires and candidates find the right job for over 25 years.")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    
            }
            .padding(40)
            .padding(.top, 40)
            if showHome {
                ContentView()
            }

        }
    }
    
    
    var background : some View {
        RiveViewModel(fileName: "shapes").view()
            .ignoresSafeArea()
            .blur(radius: 15)
            .background(
                Image("Spline")
                    .blur(radius: 10)
                .offset(x: 200, y: 100)
            )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
