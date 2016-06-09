//
//  DetailsViewController.swift
//  Affirmation
//
//  Created by Drew Westcott on 01/04/2016.
//  Copyright © 2016 Drew Westcott. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var dateSetLabel: UILabel!
    
    //Set up userdefaults
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hasMeditationRunStarted()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCellWithIdentifier("affirmations") as? AffirmationCell {
            
            return cell
        } else {
            return AffirmationCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    @IBAction func notificationSwitch(sender: AnyObject) {
        if notificationSwitch.on {
            let calendar = NSCalendar.currentCalendar()
            let currentDate = NSDate()
            let currentHour = calendar.component( [.Hour], fromDate: currentDate )
            print(currentHour)
            let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
                .Minute,
                value: 5,
                toDate: currentDate,
                options: NSCalendarOptions(rawValue: 0))
            print("tom:\(tomorrow)")
            scheduleNotification(tomorrow!, string: "I am the source of my own inner healing.")
            userDefaults.setObject(tomorrow, forKey: "meditationStartedOn")
            
        } else {
            cancelNotification()
        }
    }


    /// These functions are duplications from ViewController
    /// #todo
    func scheduleNotification(fireDate: NSDate,string: String) {
        let notification = UILocalNotification()
        notification.timeZone  = NSTimeZone.localTimeZone()
        notification.fireDate = fireDate
        notification.alertBody = string
        notification.alertAction = "Got it"
        notification.soundName = UILocalNotificationDefaultSoundName
        notification.userInfo = ["returned": "yes"]
        notification.repeatInterval = NSCalendarUnit.Day
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }

    func cancelNotification() {
        UIApplication.sharedApplication().cancelAllLocalNotifications()
    }
    
    func hasMeditationRunStarted() {
        
        if let started = userDefaults.objectForKey("meditationStartedOn") as? NSDate {
            print("Started: \(started)")
            let dateMakerFormatter = NSDateFormatter()
            dateMakerFormatter.calendar = NSCalendar.currentCalendar()
            dateMakerFormatter.dateFormat = "dd MMMM yyyy"

            let userCalendar = NSCalendar.currentCalendar()
            let meditationStarted = dateMakerFormatter.stringFromDate(started)
            //print("Medstart:\(meditationStarted)")
            dateSetLabel.text = "\(meditationStarted)"
            notificationSwitch.setOn(true, animated: true)
            
            let currentDate = NSDate()
            let madeUpDate = createDate(09, month: 06, year: 2016)
            print("Madeup \(madeUpDate)")
            //let currentDate = dateMakerFormatter.stringFromDate("11 June 2016")
            print("Current Date: \(currentDate)")
            let dayCalendarUnit: NSCalendarUnit = [.Day]
            
            let meditationDay = userCalendar.components(dayCalendarUnit, fromDate: started, toDate: madeUpDate, options: [])
            print("Days since meditation:\(meditationDay.day)")
            
        } else {
            print("Not started")
            dateSetLabel.text = ""
            notificationSwitch.setOn(false, animated: true)
        }
        
    }
    
    func createDate(day: Int, month: Int, year: Int, hour: Int = 1, minute: Int = 0) -> NSDate {
        let dateFormatter = NSDateFormatter()
        let userCalendar = NSCalendar.currentCalendar()
        
        dateFormatter.calendar = userCalendar
        dateFormatter.dateFormat = "yyyy/MM/dd hh:mm"
        
        let theDate = dateFormatter.dateFromString("\(year)/\(month)/\(day) \(hour):\(minute)")
        return theDate!
        
    }

}
