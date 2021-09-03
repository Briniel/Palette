//
//  ViewController.swift
//  Palette
//
//  Created by Михаил Иванов on 20.08.2021.
//

import UIKit

class SettingViewController: UIViewController {
    @IBOutlet var viewPalette: UIView!
    
    @IBOutlet var sliderRed: UISlider!
    @IBOutlet var sliderGreen: UISlider!
    @IBOutlet var sliderBlue: UISlider!
    
    @IBOutlet var labelRed: UILabel!
    @IBOutlet var labelGreen: UILabel!
    @IBOutlet var labelBlue: UILabel!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    var colorView: UIColor!
    var delegate: SettingDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPalette.layer.cornerRadius = 10
        
        sliderRed.value = Float(colorView.cgColor.components?[0] ?? 1)
        sliderGreen.value = Float(colorView.cgColor.components?[1] ?? 1)
        sliderBlue.value = Float(colorView.cgColor.components?[2] ?? 1)
        
        customTF(for: redTextField)
        customTF(for: greenTextField)
        customTF(for: blueTextField)
        
        setColor()
        setValueLabel(for: labelRed, labelGreen, labelBlue)
        setValueTF(for: redTextField, greenTextField, blueTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func pussButtonDone() {
        guard let color = viewPalette.backgroundColor else {
            return
        }
        delegate.setViewColor(from: color)
        self.dismiss(animated: true)
    }
    
    @IBAction func changeColor(_ sender: UISlider) {
        setColor()
        switch sender {
        case sliderRed:
            setValueTF(for: redTextField)
            setValueLabel(for: labelRed)
        case sliderGreen:
            setValueTF(for: greenTextField)
            setValueLabel(for: labelGreen)
        default:
            setValueTF(for: blueTextField)
            setValueLabel(for: labelBlue)
        }
    }
    
    private func setColor() {
        viewPalette.backgroundColor = UIColor(
            red: CGFloat(sliderRed.value),
            green: CGFloat(sliderGreen.value),
            blue: CGFloat(sliderBlue.value),
            alpha: 1
        )
    }
    
    private func setValueLabel(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case labelRed:
                labelRed.text = string(from: sliderRed)
            case labelGreen:
                labelGreen.text = string(from: sliderGreen)
            default:
                labelBlue.text = string(from: sliderBlue)
            }
        }
    }
    
    private func setValueTF(for fields: UITextField...) {
        fields.forEach { field in
            switch field {
            case redTextField:
                redTextField.text = string(from: sliderRed)
            case greenTextField:
                greenTextField.text = string(from: sliderGreen)
            default:
                blueTextField.text = string(from: sliderBlue)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(round(100 * slider.value) / 100)
    }
}

extension SettingViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let numbColor = Float(textField.text ?? "1.0") else {
            return
        }
        switch textField {
        case redTextField:
            sliderRed.value = numbColor
            setValueLabel(for: labelRed)
        case greenTextField:
            sliderGreen.value = numbColor
            setValueLabel(for: labelGreen)
        default:
            sliderBlue.value = numbColor
            setValueLabel(for: labelBlue)
        }
        setColor()
    }
}

extension SettingViewController {
    private func customTF(for field: UITextField) {
        let toolbarDone = UIToolbar()
        toolbarDone.sizeToFit()
        let barBtnDone = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(hideKey)
        )
        toolbarDone.items = [barBtnDone]
        
        field.keyboardType = .decimalPad
        field.inputAccessoryView = toolbarDone
        field.delegate = self
    }
    
    @objc private func hideKey() {
        view.endEditing(true)
    }
}
