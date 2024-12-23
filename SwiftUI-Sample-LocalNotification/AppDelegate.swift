//
//  AppDelegate.swift
//  SwiftUI-Sample-LocalNotification
//
//  Created by NanbanTaro on 2024/09/16.
//  
//

import Foundation
import NotificationCenter
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
       // リクエストのメソッド呼び出し
       NotificationManager.instance.requestPermission()

       UNUserNotificationCenter.current().delegate = self

       return true
   }

}

extension AppDelegate: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.list, .sound, .badge, .banner])
    }
}



final class NotificationManager {
   static let instance: NotificationManager = NotificationManager()

   // 権限リクエスト
   func requestPermission() {
       UNUserNotificationCenter.current()
           .requestAuthorization(options: [.alert, .sound, .badge]) { (granted, _) in
               print("Permission granted: \(granted)")
           }
   }

   // notificationの登録
   func sendNotification() {
       let content = UNMutableNotificationContent()
       content.title = "Notification Title"
       content.subtitle = "Notification Sub Title"
       content.body = "Local Notification Test"
       content.sound = .default

       guard let fileUrl = Bundle.main.url(forResource: "random_cat", withExtension: ".jpg"),
             let attachment = try? UNNotificationAttachment(identifier: fileUrl.lastPathComponent,
                                                            url: fileUrl,
                                                            options: nil)
       else {
           print("失敗")
           return
       }

       content.attachments = [attachment]

       let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
       let request = UNNotificationRequest(identifier: "notification01", content: content, trigger: trigger)

       UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
   }
}
