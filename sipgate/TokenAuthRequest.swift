//
//  TokenAuthRequest.swift
//  sipgate
//
//  Created by Daniel Heckrath on 07/02/2017.
//  Copyright © 2017 Daniel Heckrath. All rights reserved.
//

import Gloss


struct TokenAuthRequest: Glossy {
    
    let username: String?
    let password: String?
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    // MARK: - Deserialization
    
    init?(json: JSON) {
        self.username = "username" <~~ json
        self.password = "password" <~~ json
    }
    
    // MARK: - Serialization
    
    func toJSON() -> JSON? {
        return jsonify([
            "username" ~~> self.username,
            "password" ~~> self.password
            ])
    }
}
