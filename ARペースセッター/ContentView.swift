//
//  ContentView.swift
//  ARペースセッター
//
//  Created by EZIANTI KAMAL on 21/04/2026.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("ARペースセッター")
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
        .padding()
    }
}

#Preview {
    ContentView()
}
