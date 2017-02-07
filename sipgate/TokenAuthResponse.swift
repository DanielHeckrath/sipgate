//
//  TokenAuthResponse.swift
//  sipgate
//
//  Created by Daniel Heckrath on 07/02/2017.
//  Copyright © 2017 Daniel Heckrath. All rights reserved.
//

import Gloss

struct TokenAuthResponse: Decodable {
    
    let token: String?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        self.token = "token" <~~ json
    }
}
