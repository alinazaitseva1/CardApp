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

