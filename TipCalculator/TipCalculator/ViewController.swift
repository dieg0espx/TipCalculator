//
//  ViewController.swift
//  TipCalculator
//
//  Created by Diego Espinosa on 2020-04-28.
//  Copyright © 2020 Diego Espinosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var billSmountTextField: UITextField!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var tipPorcentageTextField: UITextField!
    @IBOutlet weak var btnCalculate: UIButton!
    
    @IBOutlet weak var theSlider: UISlider!
    
    var porcentage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        billSmountTextField.delegate = self
        tipPorcentageTextField.delegate = self
        btnCalculate.layer.cornerRadius = 7
        
      
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardDidShow),   name: UITextField.textDidChangeNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @IBAction func calculateTip(_ sender: UIButton) {
        let bill = (billSmountTextField.text! as NSString).floatValue
        let porcentage  = (tipPorcentageTextField.text! as NSString).floatValue
        tipAmountLabel.text = "$\(String((bill * porcentage) / 100))"
        theSlider.setValue(Float(porcentage), animated: true)
    }
    
    @IBAction func adjustTiPorcentage(_ sender: UISlider) {
        tipPorcentageTextField.text = "\(Int(sender.value))"
        porcentage = Int(sender.value)
    }
    
    
    @objc func dismissKeyboard(_ recogizer: UITapGestureRecognizer) {
        billSmountTextField.resignFirstResponder()
        tipPorcentageTextField.resignFirstResponder()
    }
    
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        let bill = (billSmountTextField.text! as NSString).intValue
        porcentage  = Int((tipPorcentageTextField.text! as NSString).intValue)
        theSlider.setValue(Float(porcentage), animated: true)
        tipAmountLabel.text = "$\(((Int(bill) * porcentage) / 100))"
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= keyboardSize.height / 2
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            if view.frame.origin.y != 0 {
                view.frame.origin.y = 0
            }
        }
    }
    
}
