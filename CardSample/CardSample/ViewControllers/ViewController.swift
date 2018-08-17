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
    
    @IBOutlet weak var firstPartCardNumberTextField: UITextField!
    @IBOutlet weak var secondPartCardNumberTextField: UITextField!
    @IBOutlet weak var thirdPartCardNumberTextField: UITextField!
    @IBOutlet weak var fourthPartCardNumberTextField: UITextField!
    
    var creditCard: CardEntity?
    var name: String?
    var cardNumber = ""
    var expireDate: String?
    var cvv: String?
    var isSlashAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCardTextFieldsDisabled()
        setTextFieldsDelegate()
    }
    
    var isValid: Bool {
            
            if securityCodeTextField.text?.count == 3, expireDateTextField.text?.count == 5, cardNumber.count == 16 {
                return true
            } else {
                if (securityCodeTextField.text?.count)! <= 3  {
                    securityCodeTextField.setBorderColor(color: .red)
                }
                if (expireDateTextField.text?.count)! <= 5 {
                    expireDateTextField.setBorderColor(color: .red)
                }
                if cardNumber.count <= 16 {
                    if firstPartCardNumberTextField.text?.count != 4 {
                        firstPartCardNumberTextField.setBorderColor(color: .red)
                    }
                    if secondPartCardNumberTextField.text?.count != 4 {
                        secondPartCardNumberTextField.setBorderColor(color: .red)
                    }
                    if thirdPartCardNumberTextField.text?.count != 4 {
                        thirdPartCardNumberTextField.setBorderColor(color: .red)
                    }
                    if fourthPartCardNumberTextField.text?.count != 4 {
                        fourthPartCardNumberTextField.setBorderColor(color: .red)
                    }
                }
            }
        
        return false
    }
    
    
    func setDefaultBorderColor(for textField: UITextField) {
        textField.setBorderColor(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    }
    
    
    @IBAction func pushedAddCard(_ sender: UIButton) {
        if isValid {
            guard let expireDate = expireDate, let cvv = cvv else { return }
            creditCard = CardEntity(
                name: name,
                cardNumber: cardNumber,
                expireDate: expireDate,
                cvv: cvv)
            print(creditCard) // TODO: remove
            
            self.showAlert(title: "Credit card", message: (creditCard?.cardEntityRepresentation)!)
        } else {
            self.showAlert(title: "Error", message: TypeError.dataIsAbsent.localizedDescription)

        }
        
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
    
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        setDefaultBorderColor(for: textField)
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        var symbolCheck = symbolsValidate(string)
        
        let limitLength: Int?
        switch textField {
        case securityCodeTextField:
            limitLength = 3
        case expireDateTextField:
//            if text.count < 2 {
//                if text.count == 0 {
//                    symbolCheck = false
//                } else {
//                    symbolCheck = DateValidatorRules(string).isValid
//                }
//            } else {
                symbolCheck = symbolsValidate(string)
//            }
            limitLength = 5
        case firstPartCardNumberTextField, secondPartCardNumberTextField, thirdPartCardNumberTextField, fourthPartCardNumberTextField:
            limitLength = 4
        default:
            limitLength = 19
        }
        let lengthValidate = newLength <= limitLength!
        
        return lengthValidate && symbolCheck
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
            case fourthPartCardNumberTextField :
                expireDateTextField.becomeFirstResponder()

            default:
                fourthPartCardNumberTextField.resignFirstResponder()
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
                if text.count == 5 {
                    securityCodeTextField.becomeFirstResponder()
                }
            }
        case securityCodeTextField:
            cvv = sender.text
            if cvv?.count == 3 {
                securityCodeTextField.setBorderColor(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
            }
        default:
            print(sender.text) // TODO: remove
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
        "expire date" : "\(expireDate)",
        "cvv" : "\(cvv)"
        """
    }
    
}
