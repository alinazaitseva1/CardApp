//
//  TextFieldExtension.swift
//  CardSample
//
//  Created by Alina Zaitseva on 8/29/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setAppropriateLookWith (color: UIColor) {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 5
        self.layer.borderColor = color.cgColor
    }
}

extension UITextField {
    func addCancelToolbar( onCancel: (target: Any, action: Selector)? = nil) {
        let onCancel = onCancel ?? (target: self, action: #selector(cancelButtonTapped))
        
        let toolbar: UIToolbar = UIToolbar()
        toolbar.barStyle = .default
        toolbar.items = [
            UIBarButtonItem(title: "Cancel", style: .plain, target: onCancel.target, action: onCancel.action),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil),
        ]
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
    }
    
    // Default actions:
    @objc func cancelButtonTapped() { self.resignFirstResponder() }
}
