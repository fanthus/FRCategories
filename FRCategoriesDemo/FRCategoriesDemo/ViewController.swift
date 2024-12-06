//
//  ViewController.swift
//  FRCategoriesDemo
//
//  Created by fanthus on 12/3/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        testUIDeviceExtension()
        testUIColorExtension()
    }
    
    func testUIDeviceExtension() {
        print(UIDevice.modelIdentifier)
    }

    func testUIColorExtension() {
        let color = UIColor("ff0000")
        self.view.backgroundColor = color
        let colorStr = color.hexString()
        print(colorStr)
    }
}

