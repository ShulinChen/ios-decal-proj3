//
//  SingleController.swift
//  Photos
//
//  Created by ShulinChen on 11/17/15.
//  Copyright © 2015 iOS DeCal. All rights reserved.
//

import UIKit

class SingleController: UIViewController {
    
    @IBOutlet weak var singleView: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var likes: UILabel!
    
    var addLike = true
 
  
    
    var photoForDetail: Photo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var imgURL: NSURL = NSURL(string: photoForDetail.url)!
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(
            request, queue: NSOperationQueue.mainQueue(),
            completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
            if error == nil {
                //display everything here
                self.singleView.image = UIImage(data: data!)
                self.name.text = "User Name: " + self.photoForDetail.username
                self.likes.text = String(self.photoForDetail.likes) + " likes"
                
//                NSDate date = NSDate .dateByAddingTimeInterval(self.photoForDetail.createdTime)
//                
//                NSDate *aDate = [NSDate dateWithTimeIntervalSince1970: interval];
//              
                
                
                let formatter = NSDateFormatter()
                formatter.dateStyle = NSDateFormatterStyle.ShortStyle
                var timeInterval = Double(self.photoForDetail.createdTime)
                var nsdate = NSDate(timeIntervalSince1970: timeInterval!)
                let dateString = formatter.stringFromDate(nsdate)
                
                self.date.text = "Date Posted: " + dateString
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func likeBtn(sender: AnyObject) {
        if addLike {
             self.likes.text = String(self.photoForDetail.likes + 1) + " likes"
        } else {
            self.likes.text = String(self.photoForDetail.likes) + " likes"
        }
        addLike = !addLike
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
