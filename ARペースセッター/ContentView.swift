//
//  ContentView.swift
//  ARペースセッター
//
//  Created by EZIANTI KAMAL on 21/04/2026.
//

import SwiftUI

struct PageView: View {
    @State private var selectedPage = 0
    
    var body: some View {
        // 1. Wrap your pages in a TabView and bind it to your state variable
        TabView(selection: $selectedPage) {
            
            // --- PAGE 1 ---
            VStack(spacing: 12) {
                Text("ARペースセッター")
                    .font(.title)
                
                Button(action: {
                    print("Start Button Pressed")
                }){
                    HStack {
                        Image(systemName: "play.fill")
                            .imageScale(.large)
                        Text("Start Workout")
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                
                Button(action: {
                    print("Stop Button Pressed")
                }){
                    HStack {
                        Image(systemName: "stop.fill")
                            .imageScale(.large)
                        Text("Stop Workout")
                    }
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
            }
            .tag(0) // 2. Assign a tag so the TabView knows this is page 0
            
            // --- PAGE 2 ---
            VStack(spacing: 12) {
                Text("Settings or Stats")
                    .font(.title)
                
                Text("This is your second page!")
                    .foregroundColor(.secondary)
            }
            .tag(1) // 3. Assign a tag for page 1
            
        }
        // 4. Apply the page style to the TabView itself
        .tabViewStyle(.page)

        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .padding()
    }
}

#Preview {
    PageView()
}
