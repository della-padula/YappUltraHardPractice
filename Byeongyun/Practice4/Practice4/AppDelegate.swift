//
//  AppDelegate.swift
//  Practice4
//
//  Created by ITlearning on 2021/10/06.
//

import UIKit
import AVFoundation

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let presenter = Presenter()
        window?.rootViewController = ViewController(with: presenter)
        window?.makeKeyAndVisible()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default)
        } catch let error as NSError {
            print("audioSession 설정 오류 \(error)")
        }
        
        return true
    }

}

