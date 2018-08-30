import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var nameOnCardTextField: UITextField!
    @IBOutlet weak var expireDateTextField: UITextField!
    @IBOutlet weak var cvvTextField: UITextField!
    
    @IBOutlet weak var firstCardNumberTextField: UITextField!
    @IBOutlet weak var secondCardNumberTextField: UITextField!
    @IBOutlet weak var thirdCardNumberTextField: UITextField!
    @IBOutlet weak var fourthCardNumberTextField: UITextField!
    
    // MARK: Properties for CardEntity data
    
    var creditCard: CardEntity?
    var name: String?
    var cardNumber = ""
    var expireDate: String?
    var cvv: String?
    var numberOfCard: CardNumber!
    
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
        numberOfCard = CardNumber()
        setTextFieldsDelegate()
    }
    // MARK: Function to appoint delegate for TextField
    
    fileprivate func setTextFieldsDelegate() {
        expireDateTextField.delegate = self
    }
    
    //MARK: Appoint color and border radius to TextField
    
    func setDefaultBorderColor(for textField: UITextField) {
        textField.setAppropriateLookWith(color: #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1))
    }
    
    // MARK: Function to validate amount of symbols in TextField
    
    private func symbolsValidate (_ string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    // MARK: Function to validate amount of numbers in TextField
    
    private func numbersValidate (_ string: String) -> Bool {
        let allowedCharacters = CharacterSet.letters
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    //MARK: Function to validate symbols amount in TextFields
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        setDefaultBorderColor(for: textField)
        
        guard let text = textField.text else { return true }
        
        let newLength = text.count + string.count - range.length
        var isValidationDone = false
        let limitLength: Int?
        
        func validationDone() {
            return  isValidationDone = symbolsValidate(string)
        }
        
        switch textField {
        case cvvTextField:
            validationDone()
            limitLength = cvvLimit
        case expireDateTextField:
            validationDone()
            limitLength = dataSymbolsLimit
        case firstCardNumberTextField, secondCardNumberTextField, thirdCardNumberTextField, fourthCardNumberTextField:
            validationDone()
            limitLength = cardNumberLimit
        default:
            isValidationDone = numbersValidate(string)
            limitLength = maxNameLimit
        }
        
        let lengthValidate = newLength <= limitLength!
        return lengthValidate && isValidationDone
    }
    
    //MARK: TextField validation checking
    
    var isValid: Bool {
        
        // MARK: amount of symbols in TextField
        
        let cvvCode = cvvTextField.text?.count
        let expireDate = expireDateTextField.text?.count
        let securityCode = cvvTextField.text?.count
        
        let firstCardNumber = firstCardNumberTextField.text?.count
        let secondCardNumber = secondCardNumberTextField.text?.count
        let thirdCardNumber = thirdCardNumberTextField.text?.count
        let fourthCardNumber = fourthCardNumberTextField.text?.count
        
        if cvvCode == cvvLimit,
            expireDate == dataSymbolsLimit,
            numberOfCard.cardNumber != nil {
            return true
        } else {
            if securityCode! < cvvLimit  {
                cvvTextField.setAppropriateLookWith(color: .red)
            }
            if expireDate! < dataSymbolsLimit {
                expireDateTextField.setAppropriateLookWith(color: .red)
            } else {
                expireDateTextField.setAppropriateLookWith(color: #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1) )
            }
            if firstCardNumber! < cardNumberLimit {
                firstCardNumberTextField.setAppropriateLookWith(color: .red)
            }
            if secondCardNumber! < cardNumberLimit {
                secondCardNumberTextField.setAppropriateLookWith(color: .red)
            }
            if thirdCardNumber! < cardNumberLimit {
                thirdCardNumberTextField.setAppropriateLookWith(color: .red)
            }
            if fourthCardNumber! < cardNumberLimit {
                fourthCardNumberTextField.setAppropriateLookWith(color: .red)
            }
        }
        return false
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
                    cvvTextField.becomeFirstResponder()
                }
            }
        case cvvTextField:
            cvv = sender.text
            if cvv?.count == cvvLimit {
                cvvTextField.resignFirstResponder()
            }
        default:
            break
        }
    }
    
    // MARK: Function for adding symbols in TextFields
    
    @IBAction func editingCardNumber(_ sender: UITextField) {
        if (sender.text?.count)! == cardNumberLimit {
            switch sender {
            case firstCardNumberTextField :
                secondCardNumberTextField.isEnabled = true
                textFieldShouldBecome(secondCardNumberTextField)
            case secondCardNumberTextField :
                thirdCardNumberTextField.isEnabled = true
                textFieldShouldBecome(thirdCardNumberTextField)
            case thirdCardNumberTextField :
                fourthCardNumberTextField.isEnabled = true
                textFieldShouldBecome(fourthCardNumberTextField)
            case fourthCardNumberTextField :
                textFieldShouldBecome(expireDateTextField)
            default:
                break
            }
            
        }
    }
    
    // MARK: Output data from CARD NUMBER TextField
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        switch textField {
        case firstCardNumberTextField:
            numberOfCard.first = text!
        case secondCardNumberTextField:
            numberOfCard.second = text!
        case thirdCardNumberTextField:
            numberOfCard.third = text!
        case fourthCardNumberTextField:
            numberOfCard.fourth = text!
        default:
            break
        }
    }
    
    // MARK: Action for pushed ADD CARD button
    
    @IBAction func pushedAddCard(_ sender: UIButton) {
        if isValid {
            guard let expireDate = expireDate, let cvv = cvv else { return }
            creditCard = CardEntity(
                name: name,
                cardNumber: numberOfCard.cardNumber!,
                expireDate: expireDate,
                cvv: cvv)
            
            self.showAlert(title: "Credit card", message: (creditCard?.Decodable)!)
        } else {
            if cvv?.count == cvvLimit {
                cvvTextField.setAppropriateLookWith(color: #colorLiteral(red: 0.9176470588, green: 0.9176470588, blue: 0.9176470588, alpha: 1))
            }
            self.showAlert(title: "Error", message: ValidationError.dataIsAbsent.localizedDescription)
        }
        
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    private func textFieldShouldBecome(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
    
}



