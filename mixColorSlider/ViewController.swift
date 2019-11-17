//
//  ViewController.swift
//  mixColorSlider
//
//  Created by Roman Kozlov on 14.11.2019.
//  Copyright © 2019 Roman Kozlov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var mixColorView: UIView!
    
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var blueLabel: UILabel!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    let alphaView: Float = 1
    let yToolBar = 0
    let xToolBar = 0
    let widtToolBar = 320
    let heightToolBar = 40
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sliderTintColor()
        viewColorChange()
        labelSetText()
        textFieldSetText()
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        
        self.addDoneButtonOnKeyboard()
    }
    
    @IBAction func sliderChangeColor(_ sender: Any) {
        viewColorChange()
        labelSetText()
        textFieldSetText()
    }
    
    func sliderTintColor() {
        redSlider.minimumTrackTintColor = .red
        greenSlider.minimumTrackTintColor = .green
        blueSlider.minimumTrackTintColor = .blue
    }
    
    func viewColorChange() {
        mixColorView.backgroundColor = .init(red: CGFloat(redSlider.value), green: CGFloat(greenSlider.value), blue: CGFloat(blueSlider.value), alpha: CGFloat(alphaView))
    }
    
    func textFieldSetText() {
        redTextField.text = redLabel.text
        greenTextField.text = greenLabel.text
        blueTextField.text = blueLabel.text
    }
    
    func labelSetText() {
        redLabel.text = String(NSString(format: "%.2f", redSlider.value))
        greenLabel.text = String(NSString(format: "%.2f", greenSlider.value))
        blueLabel.text = String(NSString(format: "%.2f", blueSlider.value))
    }
        
    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: xToolBar, y: yToolBar, width: widtToolBar, height: heightToolBar))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let done = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.redTextField.inputAccessoryView = doneToolbar
        self.greenTextField.inputAccessoryView = doneToolbar
        self.blueTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
        stringToNumberRedTextField()
        stringToNumberGreenTextField()
        stringToNumberBlueTextField()
        labelSetText()
        viewColorChange()
    }
    
    func stringToNumberRedTextField() {
        guard let inputText = redTextField.text, !inputText.isEmpty else {
            showAlert(title: "ERROR 404", message: "Empty Field!")
            textFieldSetText()
            return
        }
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: inputText)
        
        if let numberNSString = number {
            let numberFloat = Float(truncating: numberNSString)
            redSlider.value = numberFloat
        } else {
            showAlert(title: "ERROR", message: "Not a number")
            return
        }
    }

    func stringToNumberGreenTextField() {
        guard let inputText = greenTextField.text, !inputText.isEmpty else {
            showAlert(title: "ERROR 404", message: "Empty Field!")
            textFieldSetText()
            return
        }
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: inputText)
        
        if let numberNSString = number {
            let numberFloat = Float(truncating: numberNSString)
            greenSlider.value = numberFloat
        } else {
            showAlert(title: "ERROR", message: "Not a number")
            return
        }
    }
    
    func stringToNumberBlueTextField() {
        guard let inputText = blueTextField.text, !inputText.isEmpty else {
            showAlert(title: "ERROR 404", message: "Empty Field!")
            textFieldSetText()
            return
        }
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from: inputText)
        
        if let numberNSString = number {
            let numberFloat = Float(truncating: numberNSString)
            blueSlider.value = numberFloat
        } else {
            showAlert(title: "ERROR", message: "Not a number")
            return
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
}

extension ViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
