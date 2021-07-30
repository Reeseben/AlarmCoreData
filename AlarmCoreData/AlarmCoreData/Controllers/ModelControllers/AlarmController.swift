//
//  AlarmController.swift
//  AlarmCoreData
//
//  Created by Ben Erekson on 7/29/21.
//

import CoreData

class AlarmController{
    //MARK: - SharedInstance
    static var shared = AlarmController()
    
    //MARK: - SOT
    var alarms: [Alarm] = []
    
    //MARK: - Properties
    private lazy var fetchRequest : NSFetchRequest<Alarm> = {
        let request = NSFetchRequest<Alarm>(entityName: "Alarm")
        
        request.predicate = NSPredicate(value: true)
        
        return request
    }()
    
    
    //MARK: - CRUD Funcitons
    
    func createAlarm(withTitle title: String, and fireDate: Date, and isEnabled: Bool) {
        let alarm = Alarm(title: title, isEnabled: isEnabled, fireDate: fireDate)
        alarms.append(alarm)
        
        if alarm.isEnabled {
            AlarmScheduler.shared.scheduleUserNotficaiton(for: alarm)
        }
        
        CoreDataStack.saveContext()
    }
    
    func updateAlarm(alarm: Alarm, newTitle: String, newFireDate: Date, isEnabled: Bool) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms[index].title = newTitle
        alarms[index].fireDate = newFireDate
        alarms[index].isEnabled = isEnabled
        
        if alarm.isEnabled {
            AlarmScheduler.shared.scheduleUserNotficaiton(for: alarms[index])
        } else {
            AlarmScheduler.shared.clearNotifications(for: alarm)
        }
        
        CoreDataStack.saveContext()
    }
    
    func toggleIsEnabledFor(alarm: Alarm) {
        guard let index = alarms.firstIndex(of: alarm) else { return }
        alarms[index].isEnabled.toggle()
        
        if alarm.isEnabled{
            AlarmScheduler.shared.scheduleUserNotficaiton(for: alarm)
        } else {
            AlarmScheduler.shared.clearNotifications(for: alarm)
        }
        
        CoreDataStack.saveContext()
    }
    
    func delete(alarm: Alarm){
        guard let index = alarms.firstIndex(of: alarm) else { return }
        AlarmScheduler.shared.clearNotifications(for: alarm)
        alarms.remove(at: index)
        CoreDataStack.context.delete(alarm)
        
        CoreDataStack.saveContext()
    }
    
    func fetchAlarms(){
        alarms = (try? CoreDataStack.context.fetch(fetchRequest)) ?? []
    }
    
    
    
}//End Of Class
