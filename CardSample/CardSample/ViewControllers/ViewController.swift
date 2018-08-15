//
//  ViewController.swift
//  CardSample
//
//  Created by Alina Zaitseva on 8/14/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameOnCard: UITextField!
    @IBOutlet var cardNumber: [UITextField]!
    @IBOutlet weak var expireDate: UITextField!
    @IBOutlet weak var securityCode: UITextField!
    
    @IBAction func pushedAddCard(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

