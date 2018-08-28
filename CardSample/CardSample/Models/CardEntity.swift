// 
//  CardEntity.swift
//  CardSample
//
//  Created by Alina Zaitseva on 8/17/18.
//  Copyright © 2018 Alina Zaitseva. All rights reserved.
//

import Foundation

struct CardEntity {
    
    var name: String?
    var cardNumber: String
    var expireDate: String
    var cvv: String
    
    var Decodable: String {
        return """
        "name" : "\(name ?? "")",
        "card number" : "\(cardNumber)",
        "expire date" : "\(expireDate)",
        "cvv" : "\(cvv)"
        """
    }
}
