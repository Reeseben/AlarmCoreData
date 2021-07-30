//
//  AlarmScheduler.swift
//  AlarmCoreData
//
//  Created by Ben Erekson on 7/29/21.
//

import UserNotifications



class AlarmScheduler {
    
    static var shared = AlarmScheduler()
    
    func scheduleUserNotficaiton(for alarm: Alarm){
        
        clearNotifications(for: alarm)
        
        guard let title = alarm.title,
              let triggerDate = alarm.fireDate,
              let identifier = alarm.uuidString else { return }
        
        let content = UNMutableNotificationContent()
        content.title = "Alarm"
        content.body = "Alarm \(title) is going off"
        content.sound = .default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.hour, .minute], from: triggerDate), repeats: true)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add notificaiotn request \(error.localizedDescription)")
            }
        }
    }
    
    func clearNotifications(for alarm: Alarm){
        guard let identifier = alarm.uuidString else { return }
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
}
