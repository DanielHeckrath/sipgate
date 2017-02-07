//
//  GetBalanceResponse.swift
//  sipgate
//
//  Created by Daniel Heckrath on 07/02/2017.
//  Copyright © 2017 Daniel Heckrath. All rights reserved.
//

import Gloss

struct GetBalanceResponse: Decodable {
    
    let amount: Int?
    let currency: String?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        self.amount = "amount" <~~ json
        self.currency = "currency" <~~ json
    }
}
