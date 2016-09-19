//
//  ViewController.swift
//  BspWetterAppSwt
//
//  Created by Christian Bleske on 24.07.14.
//  Copyright (c) 2014 Christian Bleske. All rights reserved.
//

import UIKit

class ViewController: UIViewController{ //, NSURLConnectionDelegate {
                            
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    //lazy var data = NSMutableData()
    lazy var data = Data()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        connect()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func connect(){
        
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?q=Witten&APPID=0f215e06411c324dc85607c7ef52d78d")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!, completionHandler: {
            (data, reponse, error) in
            if (error == nil) {
                //let result = NSString(data: data!, encoding:NSASCIIStringEncoding)! as String
                self.data = data!
                print("Daten geladen...")//self.result)
                //print(result)
                
                
                DispatchQueue.main.async {
                    //Aktualisierung des UI sofern erforderlich
                    self.handleData()
                }
            } else {
                print("Fehler: %@", error!.localizedDescription);
            }
        })
        
        task.resume()
    }
    
    func handleData() {
        let jsonData: NSDictionary
        do {
            jsonData = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            //println("Inhalt von jsonResult:")
            
            let main: NSDictionary = jsonData["main"] as! NSDictionary
            let tempKelvin = main["temp"] as! Double
            let tempCelsius = tempKelvin - 273.15
            temperatureLabel.text = NSString(format: "%.2f", tempCelsius) as String
            let weather: NSArray = (jsonData["weather"] as? NSArray)!
            let weatherData: NSDictionary = weather[0] as! NSDictionary
            let description = String(weatherData["description"] as! NSString)
            self.weatherDescriptionLabel.text = description
            let icon = String(weatherData["icon"] as! NSString)
            let image1 = UIImage(named: icon)
            self.weatherImage.image = image1
            /*  println("main")
             println(main)
             println("weather")
             println(weather) */
            
        } catch {
            print("Fehler aufgetreten!")
        }
    }
    
}

