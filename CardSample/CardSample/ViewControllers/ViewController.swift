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
    
    // MARK: Properties for CardEntity data
    
    var creditCard: CardEntity?
    var name: String?
    var cardNumber = ""
    var expireDate: String?
    var cvv: String?
    
    var isSlashAdded = false
    
    // MARK: Properties to limit amount in TextFields
    
    let cvvLimit = 3
    let cardNumberLimit = 4
    let maxNameLimit = 19
    let dataSymbolsLimit = 5
    let symbolsBeforeBackslash = 2
    let amountOfCardNumbers = 16
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTextFieldsDelegate()
    }
    
    var isValid: Bool {
        
        if securityCodeTextField.text?.count == cvvLimit, expireDateTextField.text?.count == dataSymbolsLimit, cardNumber.count == amountOfCardNumbers {
            return true
        } else {
            if (securityCodeTextField.text?.count)! < cvvLimit  {
                securityCodeTextField.setBorderColor(color: .red)
            }
            if (expireDateTextField.text?.count)! < dataSymbolsLimit {
                expireDateTextField.setBorderColor(color: .red)
            } else {
                expireDateTextField.setBorderColor(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
            }
            if cardNumber.count <= amountOfCardNumbers {
                if firstPartCardNumberTextField.text?.count != cardNumberLimit {
                    firstPartCardNumberTextField.setBorderColor(color: .red)
                }
                if secondPartCardNumberTextField.text?.count != cardNumberLimit {
                    secondPartCardNumberTextField.setBorderColor(color: .red)
                }
                if thirdPartCardNumberTextField.text?.count != cardNumberLimit {
                    thirdPartCardNumberTextField.setBorderColor(color: .red)
                }
                if fourthPartCardNumberTextField.text?.count != cardNumberLimit {
                    fourthPartCardNumberTextField.setBorderColor(color: .red)
                }
            }
        }
        return false
    }
    
    
    func setDefaultBorderColor(for textField: UITextField) {
        textField.setBorderColor(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
    }
    
    // MARK: Action for pushed add card button
    
    @IBAction func pushedAddCard(_ sender: UIButton) {
        if isValid {
            guard let expireDate = expireDate, let cvv = cvv else { return }
            creditCard = CardEntity(
                name: name,
                cardNumber: cardNumber,
                expireDate: expireDate,
                cvv: cvv)
            
            self.showAlert(title: "Credit card", message: (creditCard?.Decodable)!)
        } else {
            if cvv?.count == cvvLimit {
                securityCodeTextField.setBorderColor(color: #colorLiteral(red: 0.9411764706, green: 0.9411764706, blue: 0.9411764706, alpha: 1))
            }
            self.showAlert(title: "Error", message: ValidationError.dataIsAbsent.localizedDescription)
        }
        
    }
    
    
     // MARK: Function to appoint delegate for TextField
    
    fileprivate func setTextFieldsDelegate() {
        firstPartCardNumberTextField.delegate = self
        secondPartCardNumberTextField.delegate = self
        thirdPartCardNumberTextField.delegate = self
        fourthPartCardNumberTextField.delegate = self
        securityCodeTextField.delegate = self
        expireDateTextField.delegate = self
        nameOnCardTextField.delegate = self
    }
    
    //MARK: Function to validate amount of symbols in TextFields
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        setDefaultBorderColor(for: textField)
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        var isValidationDone = false
        
        let limitLength: Int?
        switch textField {
        case securityCodeTextField:
            isValidationDone = symbolsValidate(string)
            limitLength = cvvLimit
        case expireDateTextField:
            isValidationDone = symbolsValidate(string)
            limitLength = dataSymbolsLimit
        case firstPartCardNumberTextField, secondPartCardNumberTextField, thirdPartCardNumberTextField, fourthPartCardNumberTextField:
            isValidationDone = symbolsValidate(string)
            limitLength = cardNumberLimit
        default:
            isValidationDone = numbersValidate(string)
            limitLength = maxNameLimit
        }
        let lengthValidate = newLength <= limitLength!
        
        return lengthValidate && isValidationDone
    }
    
    // MARK: Function to adding symbols in TextFields
    
    @IBAction func editingCardNumber(_ sender: UITextField) {
        if (sender.text?.count)! == cardNumberLimit {
            cardNumber += sender.text!
            switch sender {
            case firstPartCardNumberTextField :
                secondPartCardNumberTextField.isEnabled = true
                secondPartCardNumberTextField.resignFirstResponder()
                secondPartCardNumberTextField.becomeFirstResponder()
            case secondPartCardNumberTextField :
                thirdPartCardNumberTextField.isEnabled = true
                thirdPartCardNumberTextField.resignFirstResponder()
                thirdPartCardNumberTextField.becomeFirstResponder()
            case thirdPartCardNumberTextField :
                fourthPartCardNumberTextField.isEnabled = true
                fourthPartCardNumberTextField.resignFirstResponder()
                fourthPartCardNumberTextField.becomeFirstResponder()
            case fourthPartCardNumberTextField :
                expireDateTextField.becomeFirstResponder()
                fourthPartCardNumberTextField.resignFirstResponder()
            default:
                break
            }
        }
    }
    
    private func symbolsValidate (_ string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    private func numbersValidate (_ string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return !allowedCharacters.isSuperset(of: characterSet)
    }
    
    // MARK: Function to remove/add backslash
    
    @IBAction func editingTextField(_ sender: UITextField) {
        switch sender {
        case nameOnCardTextField:
            name = sender.text
        case expireDateTextField:
            
            expireDate = sender.text
            if let text = sender.text {
                if text.count == symbolsBeforeBackslash {
                    if isSlashAdded {
                        sender.text = "\(text.first!)"
                        isSlashAdded = false
                    } else {
                        sender.text = "\(text)/"
                        isSlashAdded = true
                    }
                }
                if text.count == dataSymbolsLimit {
                    securityCodeTextField.becomeFirstResponder()
                }
            }
        case securityCodeTextField:
            cvv = sender.text
            if cvv?.count == cvvLimit {
                securityCodeTextField.resignFirstResponder()
            }
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
