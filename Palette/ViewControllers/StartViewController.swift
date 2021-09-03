//
//  StartViewController.swift
//  Palette
//
//  Created by Михаил Иванов on 03.09.2021.
//

import UIKit

protocol SettingDelegate {
    func setViewColor(from uIColor: UIColor)
}

class StartViewController: UIViewController {
    @IBOutlet var mainView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingVS = segue.destination as? SettingViewController else {
            return
        }
        settingVS.colorView = mainView.backgroundColor
        settingVS.delegate = self
    }
}

extension StartViewController: SettingDelegate {
    func setViewColor(from uIColor: UIColor) {
        mainView.backgroundColor = uIColor
    }
}
