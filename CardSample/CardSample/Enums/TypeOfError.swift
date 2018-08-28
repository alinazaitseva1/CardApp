// 
//  TypeError.swift
//  CardSample
//
//  Created by Alina Zaitseva on 8/16/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

enum TypeOfError: Error {
    case dataIsAbsent
    
    var localizedDescription: String {
        switch self {
        case .dataIsAbsent:
            return NSLocalizedString("Required fields cannot be left blank", comment: "All fields should be filled in")
        }
    }
}
