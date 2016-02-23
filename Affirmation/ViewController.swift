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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imagePicker.delegate = self
        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
        
        screenSize.text = "\(screenHeight)"
        var countdown : NSTimer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: "hideIt", userInfo: nil, repeats: false)
        let date = NSDate()
        var calendar = NSCalendar.currentCalendar()
       // var components = calendar.component( [.Hour, .Minute, .Month, .Year, .Day], fromDate: date )
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
    

}

