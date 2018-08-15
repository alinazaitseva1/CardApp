//
//  ViewController.swift
//  CardSample
//
//  Created by Alina Zaitseva on 8/14/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var nameOnCardTextField: UITextField!
    @IBOutlet weak var expireDateTextField: UITextField!
    @IBOutlet weak var securityCodeTextField: UITextField!
    var creditCard: CardEntity?
    var name: String?
    var cardNumber: [String]?
    var expireDate: String?
    var cvv: String?
    
    @IBOutlet weak var firstPartCardNumberTextField: UITextField!
    @IBOutlet weak var secondPartCardNumberTextField: UITextField!
    @IBOutlet weak var thirdPartCardNumberTextField: UITextField!
    @IBOutlet weak var fourthPartCardNumberTextField: UITextField!
    
    
    @IBAction func pushedAddCard(_ sender: UIButton) {
        creditCard = CardEntity(name: name,
                                cardNumber: "111",
                                expireDate: expireDate!,
                                cvv: cvv!)
        print(creditCard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondPartCardNumberTextField.isEnabled = false
        thirdPartCardNumberTextField.isEnabled = false
        fourthPartCardNumberTextField.isEnabled = false
        
    }
    @IBAction func editingCardNumber(_ sender: UITextField) {
        if (sender.text?.count)! == 4 {
            cardNumber?.append(sender.text!)
            switch sender {
            case firstPartCardNumberTextField :
                secondPartCardNumberTextField.isEnabled = true
            case secondPartCardNumberTextField :
                thirdPartCardNumberTextField.isEnabled = true
            case thirdPartCardNumberTextField :
                fourthPartCardNumberTextField.isEnabled = true
            default:
                print(sender)
            }
        }
    }
    
    
    @IBAction func editingTextField(_ sender: UITextField) {
        switch sender {
        case nameOnCardTextField:
            name = sender.text
        case expireDateTextField:
           expireDate = sender.text
        case securityCodeTextField:
            cvv = sender.text
        default:
            print(sender.text)
        }
    }
}


struct CardEntity {
    
    var name: String?
    var cardNumber: String
    var expireDate: String
    var cvv: String

}
