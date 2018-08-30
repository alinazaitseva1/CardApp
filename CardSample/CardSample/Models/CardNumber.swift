// 
//  CardNumber.swift
//  CardSample
//
//  Created by Alina Zaitseva on 8/30/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

struct CardNumber {
    var first: String = ""
    var second: String = ""
    var third: String = ""
    var fourth: String = ""
    
    private var numberOfCharactersInPart = 4
    
    var cardNumber: String? {
        if checkQuantity(of: first),
            checkQuantity(of: second),
            checkQuantity(of: third),
            checkQuantity(of: fourth) {
            return first + second + third + fourth
        }
        return nil
    }
    
    private func checkQuantity(of part: String) -> Bool {
        return part.count == numberOfCharactersInPart
    }
}
