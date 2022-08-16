//
//  HomeView.swift
//  AnimatedStepshot
//
//  Created by Mazen Mezher on 2022-06-08.
//

import SwiftUI

struct HomeView: View {
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            ScrollView {
                content
            }
        }
    }
    
    var content: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Home")
                .customFont(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(courses) { jobs in
                        VCard(course: jobs)
                    }
                }
                .padding(20)
                .padding(.bottom, 10)
            }
            
            Text("Our advice")
                .customFont(.title3)
                .padding(.horizontal, 20)
            
            VStack(spacing: 20) {
                ForEach(courseSections) { section in
                    HCard(section: section)
                }
            }
            .padding(20)
            
            Text(colorScheme == .dark ? "In dark mode" : "In light mode")
                .padding()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
