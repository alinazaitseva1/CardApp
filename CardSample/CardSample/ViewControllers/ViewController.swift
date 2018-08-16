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
    var cardNumber = ""
    var expireDate: String?
    var cvv: String?
    
    
    @IBOutlet weak var firstPartCardNumberTextField: UITextField!
    @IBOutlet weak var secondPartCardNumberTextField: UITextField!
    @IBOutlet weak var thirdPartCardNumberTextField: UITextField!
    @IBOutlet weak var fourthPartCardNumberTextField: UITextField!
    
    
    @IBAction func pushedAddCard(_ sender: UIButton) {
        creditCard = CardEntity(name: name,
                                cardNumber: cardNumber,
                                expireDate: expireDate!,
                                cvv: cvv!)
        print(creditCard)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondPartCardNumberTextField.isEnabled = false
        thirdPartCardNumberTextField.isEnabled = false
        fourthPartCardNumberTextField.isEnabled = false
        firstPartCardNumberTextField.delegate = self
        secondPartCardNumberTextField.delegate = self
        thirdPartCardNumberTextField.delegate = self
        fourthPartCardNumberTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let length = 4
        let newLength = text.count + string.count - range.length
        return newLength <= length
    }
    @IBAction func editingCardNumber(_ sender: UITextField) {
        if (sender.text?.count)! == 4 {
            cardNumber += sender.text!
            switch sender {
            case firstPartCardNumberTextField :
                secondPartCardNumberTextField.isEnabled = true
                secondPartCardNumberTextField.becomeFirstResponder()
            case secondPartCardNumberTextField :
                thirdPartCardNumberTextField.isEnabled = true
                thirdPartCardNumberTextField.becomeFirstResponder()
            case thirdPartCardNumberTextField :
                fourthPartCardNumberTextField.isEnabled = true
                fourthPartCardNumberTextField.becomeFirstResponder()
            default:
                fourthPartCardNumberTextField.resignFirstResponder()
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
