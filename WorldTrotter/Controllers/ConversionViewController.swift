//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by Peter on 21/01/2019.
//  Copyright © 2019 Excellence. All rights reserved.
//

import Foundation
import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate{
    
    //MARK: - Stored Properities
    
    var fahrenheitValue: Measurement<UnitTemperature>? {
        didSet{
            updateCelsiusLabel()
        }
    }
    
    var celsiusValue : Measurement<UnitTemperature>? {
        if let fahrenheitValue = fahrenheitValue{
            return fahrenheitValue.converted(to: .celsius)
        }else{
            return nil
        }
    }
    
    // MAKR: - Instance Methods
    
    func updateCelsiusLabel(){
        if let celsiusValue = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: celsiusValue.value))
        }else{
            celsiusLabel.text = "???"
        }
    }
    
    // MARK: - VC Life Cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCelsiusLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let hour = Calendar.current.component(.hour, from: Date())
        print(hour)
        switch hour {
        case 0...7:
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        case 8...15:
            view.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9568627451, blue: 0.9450980392, alpha: 1)
        case 15...16:
            view.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        case 17...24:
            view.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        default: break
        }
    }
    
    // MARK: - Formatters
    
    let numberFormatter: NumberFormatter = {
        let nf = NumberFormatter()
        nf.numberStyle = .decimal
        nf.minimumFractionDigits = 0
        nf.maximumFractionDigits = 1
        return nf
    }()
    
    // MARK: - @IBOutlests & @IBActions
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func dismissKeyboard(_ sedner: UITapGestureRecognizer){
        textField.resignFirstResponder()
    }
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        if let text = textField.text, let value = numberFormatter.number(from: text){
            fahrenheitValue = Measurement(value: value.doubleValue, unit: .fahrenheit)
        }else{
            fahrenheitValue = nil
        }
        
    }
    
    
    // MARK: - UITextField Delegte Methods
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let currentLocale = Locale.current
        let decimalSeparator = currentLocale.decimalSeparator ?? "."
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        
      
        let replacementTextIsACharacter:Bool = {
            for uni in string.unicodeScalars{
                if NSCharacterSet.letters.contains(uni){
                    return true
                }
            }
            return false
        }()
        
        if replacementTextIsACharacter {
            return false
        }
        
        if existingTextHasDecimalSeparator != nil,
            replacementTextHasDecimalSeparator != nil {
            return false
        }else{
            return true
        }
    }
}

