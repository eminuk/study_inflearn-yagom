//
//  ViewController.swift
//  UpDown
//
//  Created by 이민욱 on 2020/03/05.
//  Copyright © 2020 FishinGom. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Properties
    // MARK: - IBOutlets
    @IBOutlet var resultLable: UILabel!
    @IBOutlet var turnCountLabel: UILabel!
    @IBOutlet var inputField: UITextField!
    
    // MARK: - Methods
    @IBAction func touchUpSubmitButton(_ sender: UIButton) {
        print("touch up submit button")
    }
    @IBAction func touchUpResetButton(_ sender: UIButton) {
        print("touch up reset button")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

