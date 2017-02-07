//
//  ErrorResponse.swift
//  sipgate
//
//  Created by Daniel Heckrath on 07/02/2017.
//  Copyright © 2017 Daniel Heckrath. All rights reserved.
//

import Gloss

struct ErrorResponse: Decodable {
    
    let error: String?
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        self.error = "error" <~~ json
    }
}
