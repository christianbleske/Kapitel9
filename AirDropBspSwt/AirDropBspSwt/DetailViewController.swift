//
//  DetailViewController.swift
//  AirDropBspSwt
//
//  Created by Christian Bleske on 20.08.14.
//  Copyright (c) 2014 Christian Bleske. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var uiwebView: UIWebView!
    @IBAction func button_pressed(_ sender: AnyObject) {
        let fileUrl = self.getFilePath(self.detailItem as! NSString)

        let uiActivityViewController : UIActivityViewController = UIActivityViewController(activityItems: [fileUrl], applicationActivities: nil)
        
        let excludedActivitiesTypes:NSArray = [UIActivityType.postToTwitter, UIActivityType.postToFacebook,
        UIActivityType.postToWeibo,
        UIActivityType.message, UIActivityType.mail,
        UIActivityType.print, UIActivityType.copyToPasteboard,
        UIActivityType.assignToContact, UIActivityType.saveToCameraRoll,
        UIActivityType.addToReadingList, UIActivityType.postToFlickr,
        UIActivityType.postToVimeo, UIActivityType.postToTencentWeibo]
        
        uiActivityViewController.excludedActivityTypes = excludedActivitiesTypes as? [UIActivityType]
        
        self.navigationController!.present(uiActivityViewController, animated: true, completion: nil)
        
    }


    var detailItem: AnyObject? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    func configureView() {
        // Update the user interface for the detail item.
        if let _: AnyObject = self.detailItem {
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
        
        let fileUrl = self.getFilePath(self.detailItem as! NSString)
        let request = URLRequest(url: fileUrl)
        self.uiwebView.loadRequest(request)
    }
    
    func getFilePath(_ filename:NSString)-> URL {
        var filenameSeparated:[String]
        filenameSeparated = filename.components(separatedBy: ".") as [String]
        let path = Bundle.main.path(forResource: filenameSeparated[0] as String, ofType: filenameSeparated[1] as String)
        let _url = URL(string: path!)
        return _url!
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

