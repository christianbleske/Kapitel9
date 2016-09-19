//
//  ViewController.swift
//  iCloudBsp
//
//  Created by Christian Bleske on 13.02.15.
//  Copyright (c) 2015 Christian Bleske. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var uiTextField: UITextField!
    
    let keyStore = NSUbiquitousKeyValueStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textString = keyStore.string(forKey: "TEXT_ENTRY") as NSString?
        
        if (textString != nil){
            self.uiTextField.text = textString as? String
        } else {
            self.uiTextField.text = "Keine Daten!"
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.ubiquitousKeyValueStoreDidChange(_:)), name: NSUbiquitousKeyValueStore.didChangeExternallyNotification, object: keyStore)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnSaveText_Pressed(_ sender: AnyObject) {
        saveValue()
    }
    
    func saveValue()
    {
        keyStore.set(uiTextField.text, forKey: "TEXT_ENTRY")
        keyStore.synchronize()
    }
    
    func ubiquitousKeyValueStoreDidChange (_ notification:Notification) {
        showAlertViewWithTitle("Achtung Aktualisierung!",message: "Im iCloud key-value store wurde eine Änderung festgestellt.")
        self.uiTextField.text = keyStore.string(forKey: "TEXT_ENTRY")

    }
    
    func showAlertViewWithTitle(_ title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
        }
        
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true) {
        }
        
    }


}

