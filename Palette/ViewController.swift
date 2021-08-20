//
//  ViewController.swift
//  Palette
//
//  Created by Михаил Иванов on 20.08.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var viewPalette: UIView!
    
    @IBOutlet var slideRed: UISlider!
    
    @IBOutlet var slideGreen: UISlider!
    @IBOutlet var slideBlue: UISlider!
    
    @IBOutlet var labelRed: UILabel!
    @IBOutlet var labelGreen: UILabel!
    @IBOutlet var labelBlue: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewPalette.layer.cornerRadius = 10
        labelRed.text = String(slideRed.value)
        labelGreen.text = String(slideGreen.value)
        labelBlue.text = String(slideBlue.value)
    }
    
    @IBAction func changeColor() {
        viewPalette.backgroundColor = UIColor(red: CGFloat(slideRed.value), green: CGFloat(slideGreen.value), blue: CGFloat(slideBlue.value), alpha: 1)
        
        labelRed.text = String(round(100 * slideRed.value)/100)
        labelGreen.text = String(round(100 * slideGreen.value)/100)
        labelBlue.text = String(round(100 * slideBlue.value)/100)
    }
}
