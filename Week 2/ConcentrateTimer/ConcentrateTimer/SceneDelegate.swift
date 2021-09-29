//
//  SceneDelegate.swift
//  ConcentrateTimer
//
//  Created by 권준상 on 2021/09/15.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
        
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let start = UserDefaults.standard.object(forKey: "sceneDidEnterBackground") as? Date else { return }
        let interval = Int(Date().timeIntervalSince(start))
        NotificationCenter.default.post(name: NSNotification.Name("sceneWillEnterForeground"), object: nil,userInfo: ["time" : interval])
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        NotificationCenter.default.post(name: NSNotification.Name("sceneDidEnterBackground"), object: nil)
        UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
        
        let notiTime = GoalTimerViewController.count
        
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings() {
                settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    let nContents = UNMutableNotificationContent()
                    nContents.title = "집중 시간을 달성했어요!"
                    nContents.sound = UNNotificationSound.default
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(notiTime), repeats: false)
                    let request = UNNotificationRequest(identifier: "finishNotification", content: nContents, trigger: trigger)
                    UNUserNotificationCenter.current().add(request)
                }
            }
        }
    }


}

