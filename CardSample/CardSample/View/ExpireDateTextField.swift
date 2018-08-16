// 
//  ExpireDateTextField.swift
//  CardSample
//
//  Created by Alina Zaitseva on 8/16/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import UIKit

class ExpireDateTextField: UITextField {
    var value: ExpireDateEntity? {
        guard let parsedDate = text?.split(separator: "/") else { return nil }
        return ExpireDateEntity(month: String(parsedDate[0]), year: String(parsedDate[1]))
    }
}

struct ExpireDateEntity {
    let month: String
    let year: String
}
