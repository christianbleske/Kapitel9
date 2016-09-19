//
//  ViewController.swift
//  HTMLBsp
//
//  Created by Christian Bleske on 08.02.15.
//  Copyright (c) 2015 Christian Bleske. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var uiWebView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func uiButtonEmbeddedHtml_Pressed(sender: AnyObject) {
        embeddedHTML()
    }

    @IBAction func uiButtonHtmlFromFile_Pressed(sender: AnyObject) {
        loadHTMLFromFile()
    }

    @IBAction func uiButtonHtmlFromFileWithImage_Pressed(sender: AnyObject) {
        loadHTMLFromFileWithImage()
    }
    
    func loadHTMLFromFile() {
        let url = NSURL(fileURLWithPath: Bundle.main.pathForResource("htmlpage", ofType: "htm")!)
        //var url = NSURL(string: "http://www.apple.de")
        let request = NSURLRequest(url: url as URL)
        uiWebView.loadRequest(request as URLRequest)

    }
    
    func embeddedHTML() {
        let htmlHead = "<html><head><title>Eingebettetes HTML</title></head>"
        let htmlBody = "<body><b>Ein beispiel für embedded HTML in iOS</b></body>"
        var htmlCode = htmlHead + htmlBody
        htmlCode += "</html>"
        uiWebView.loadHTMLString(htmlCode, baseURL: nil)
    }
    
    func loadHTMLFromFileWithImage() {
        let url = NSURL(fileURLWithPath: Bundle.main.pathForResource("htmlpage2", ofType: "htm")!)
        //var html = String(contentsOfURL: NSURL(string: url)!, encoding: NSUTF8StringEncoding, error: nil)
        let request = NSURLRequest(url: url as URL)
        uiWebView.loadRequest(request as URLRequest)
    }
}

