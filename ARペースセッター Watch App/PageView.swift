import SwiftUI

struct PageView: View {
    @State private var selectedPage = 0
    @State private var isWorkoutActive = false
    
    // 1. WorkoutManagerを画面に接続
    @StateObject private var workoutManager = WorkoutManager()
    
    var body: some View {
        TabView(selection: $selectedPage) {
            
            // --- PAGE 1: メイン画面 ---
            VStack(spacing: 12) {
                Text(isWorkoutActive ? "Workout Active" : "ARペースセッター")
                    .font(.headline)
                    .foregroundColor(isWorkoutActive ? .green : .primary)
                
                // 2. マネージャーから計算されたペースを表示！
                Text(workoutManager.currentPace)
                    .font(.system(size: 40, weight: .bold, design: .rounded))
                    .foregroundColor(.yellow)
                
                HStack(spacing: 20) {
                    Button(action: {
                        isWorkoutActive = true
                        workoutManager.startWorkout() // 計測スタート
                    }){
                        Image(systemName: "play.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                    .disabled(isWorkoutActive)
                    
                    Button(action: {
                        isWorkoutActive = false
                        workoutManager.stopWorkout() // 計測ストップ
                    }){
                        Image(systemName: "stop.fill")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    .disabled(!isWorkoutActive)
                }
            }
            .tag(0)
            
            // --- PAGE 2: スタッツ ---
            VStack(spacing: 12) {
                Text("Stats")
                    .font(.headline)
                
                // 3. 心拍数のプレースホルダー表示
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                    Text("\(workoutManager.heartRate) bpm")
                        .font(.title2)
                }
            }
            .tag(1)
            
            // --- PAGE 3: 設定 ---
            VStack(spacing: 12) {
                Text("Settings")
                    .font(.headline)
                Text("Page 3 Content")
                    .foregroundColor(.secondary)
            }
            .tag(2)
        }
        .tabViewStyle(.page)
        // 4. アプリ起動時にセンサーの許可をユーザーに求める
        .onAppear {
            workoutManager.requestAuthorization()
        }
    }
}

#Preview {
    PageView()
}
