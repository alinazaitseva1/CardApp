// 
//  TypeError.swift
//  CardSample
//
//  Created by Alina Zaitseva on 8/16/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

enum TypeError: Error {
    case dataIsAbsent
    
    var localizedDescription: String {
        switch self {
        case .dataIsAbsent:
            return "Please fill in all fields"
        }
    }
}
