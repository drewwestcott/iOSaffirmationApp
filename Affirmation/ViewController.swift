//
//  ViewController.swift
//  Affirmation
//
//  Created by Drew Westcott on 22/11/2015.
//  Copyright © 2015 Drew Westcott. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {

    @IBOutlet weak var affirmText: UITextView!
    @IBOutlet weak var affirmationBackground: UIImageView!
    let imagePicker = UIImagePickerController()
    let screenHeight = UIScreen.mainScreen().bounds.height
    @IBOutlet weak var screenSize: UILabel!
    
    var meditaion = [Affirmation]()
    
    //Set up userdefaults
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        parseCSV()
        
        let todaysThought = meditaion[2]
        print(todaysThought.centeringThought)
        affirmText.text = todaysThought.centeringThought
        
        imagePicker.delegate = self
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        screenSize.text = "\(screenHeight)"
        if screenHeight > 999 {
            //
        }
        
        var countdown : NSTimer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: #selector(ViewController.hideIt), userInfo: nil, repeats: false)
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        
        let currentDate = NSDate()
        let currentHour = calendar.component( [.Hour], fromDate: currentDate )
        print(currentHour)
        let tomorrow = NSCalendar.currentCalendar().dateByAddingUnit(
            .Day,
            value: 1,
            toDate: currentDate,
            options: NSCalendarOptions(rawValue: 0))
        print(tomorrow)
        

        var fireDate: NSDate = calendar.dateBySettingHour(5, minute: 05, second: 0, ofDate: date, options: NSCalendarOptions())!

        self.affirmText.delegate = self
        self.resignFirstResponder()
        
        scheduleNotification(fireDate, string: "Face the worst, believe the best!")
        
        fireDate = calendar.dateBySettingHour(13, minute: 05, second: 0, ofDate: date, options: NSCalendarOptions())!
        scheduleNotification(fireDate, string: "If you want to be Happy, set a goal that commands your thoughts…")


    }

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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func settingsPressed(sender: AnyObject) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            affirmationBackground.contentMode = .ScaleAspectFill
            affirmationBackground.image = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            affirmText.resignFirstResponder()
            return false
        }
        return true
        
    }
    
    func hideIt() {
        screenSize.hidden = true
    }
    
    func parseCSV() {
        let path = NSBundle.mainBundle().pathForResource("shedding-weight", ofType: "csv")!
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                let day = Int(row["Day"]!)!
                let thought = row["Thought"]!
                let mantra = row["Mantra"]!
                let meaning = row["Meaning"]!
                let daysMed = Affirmation(day: day, centeringThought: thought, mantra: mantra, mantraMeaning: meaning)
                //pokemon.append(poke)
                meditaion.append(daysMed)
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        for med in meditaion {
            print(med.centeringThought)
        }
    }


}

