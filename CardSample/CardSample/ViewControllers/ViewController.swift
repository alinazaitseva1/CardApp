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
        guard let expireDate = expireDate, let cvv = cvv else { return }
        creditCard = CardEntity(
            name: name,
            cardNumber: cardNumber,
            expireDate: expireDate,
            cvv: cvv)
        print(creditCard)
        
        let alert = UIAlertController(title: "Credit card", message: creditCard?.cardEntityRepresentation, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    fileprivate func setCardTextFieldsDisabled() {
        secondPartCardNumberTextField.isEnabled = false
        thirdPartCardNumberTextField.isEnabled = false
        fourthPartCardNumberTextField.isEnabled = false
    }
    
    fileprivate func setTextFieldsDelegate() {
        firstPartCardNumberTextField.delegate = self
        secondPartCardNumberTextField.delegate = self
        thirdPartCardNumberTextField.delegate = self
        fourthPartCardNumberTextField.delegate = self
        securityCodeTextField.delegate = self
        expireDateTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCardTextFieldsDisabled()
        setTextFieldsDelegate()
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        
        let limitLength: Int?
        switch textField {
        case securityCodeTextField:
            limitLength = 3
        case expireDateTextField:
            limitLength = 5
        case firstPartCardNumberTextField, secondPartCardNumberTextField, thirdPartCardNumberTextField, fourthPartCardNumberTextField:
            limitLength = 4
        default:
            limitLength = 19
        }
        
        let lengthValidate = newLength <= limitLength!
        
        return lengthValidate && symbolsValidate(string)
        
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
    
    var isSlashAdded = false
    
    @IBAction func editingExpireDate(_ sender: UITextField) {
        if let text = sender.text {
            if text.count == 2 {
                if isSlashAdded {
                    sender.text = String("\(text.first!)")
                    isSlashAdded = false
                } else {
                    sender.text = String("\(text)/")
                    isSlashAdded = true
                }
            }
        }
    }
    
    private func symbolsValidate (_ string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
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
    
    var cardEntityRepresentation: String {
        return """
        "name" : "\(name ?? "")",
        "card number" : "\(cardNumber)",
        "expire date" : "\(expireDate)",+
        
        "cvv" : "\(cvv)"
"""
    }

}
