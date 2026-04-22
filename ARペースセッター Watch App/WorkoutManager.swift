//
//  WorkoutManager.swift
//  ARペースセッター
//
//  Created by EZIANTI KAMAL on 22/04/2026.
//


import Foundation
import CoreLocation
import HealthKit

class WorkoutManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // センサーの管理オブジェクト
    private let locationManager = CLLocationManager()
    private let healthStore = HKHealthStore()
    
    // UI（画面）に自動反映させるための変数
    @Published var currentPace: String = "-'--\"" // 例: 4'30"
    @Published var heartRate: Int = 0
    
    override init() {
        super.init()
        // GPSの設定
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.allowsBackgroundLocationUpdates = true
    }
    
    // MARK: - 権限のリクエスト
    func requestAuthorization() {
        // 1. GPSの許可を要求
        locationManager.requestWhenInUseAuthorization()
        
        // 2. HealthKit（心拍数）の許可を要求
        if HKHealthStore.isHealthDataAvailable() {
            let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
            healthStore.requestAuthorization(toShare: nil, read: [heartRateType]) { success, error in
                if success {
                    print("HealthKitの許可を取得しました")
                }
            }
        }
    }
    
    // MARK: - ワークアウトの制御
    func startWorkout() {
        locationManager.startUpdatingLocation()
        // ※ここにHealthKitのワークアウトセッション開始処理を追加していきます
    }
    
    func stopWorkout() {
        locationManager.stopUpdatingLocation()
        // ※ここにHealthKitの停止処理を追加します
        
        DispatchQueue.main.async {
            self.currentPace = "-'--\""
            self.heartRate = 0
        }
    }
    
    // MARK: - GPSデータの受信とペース計算
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // スピード（秒速 m/s）を取得
        let speed = location.speed
        
        // スピードが0以上の場合のみペース（分/km）を計算
        if speed > 0 {
            let secondsPerKm = 1000.0 / speed // 1km走るのにかかる秒数
            let minutes = Int(secondsPerKm / 60)
            let seconds = Int(secondsPerKm.truncatingRemainder(dividingBy: 60))
            
            // 異常な数値（例：時速1km未満）を除外するための簡単なフィルター
            if minutes < 20 {
                DispatchQueue.main.async {
                    self.currentPace = String(format: "%d'%02d\"", minutes, seconds)
                }
            }
        }
    }
}