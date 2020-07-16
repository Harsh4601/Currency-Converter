//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Harsh Londhekar on 16/07/20.
//  Copyright © 2020 Harsh Londhekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource {
    
    var myCurrency:[String] = []
    var myValues:[Double] = []
    var activeCurrency:Double = 0;
    
    
    //Objects
    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var output: UILabel!
    
    //Creating Picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myCurrency.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrency = myValues[row]
    }
    
    //BUTTON
    @IBAction func action(_ sender: UIButton) {
        if (input.text != ""){
            
                  output.text = String(Double(input.text!)! * activeCurrency)
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Getting Data
        let url = URL(string: "https://api.exchangeratesapi.io/latest")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print("ERROR")
            } else {
                if let content = data {
                    do {
                        let myJson = try JSONSerialization.jsonObject(with: content , options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary{
                            for(key,value) in rates{
                                self.myCurrency.append( (key as? String)!)
                                self.myValues.append((value as? Double)!)
                            }
                            
                            print(self.myCurrency)
                            print(self.myValues)
                        }
                    } catch {
                        
                    }
                }
            }
            self.pickerView.reloadAllComponents()
        }
        task.resume()
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }



}
