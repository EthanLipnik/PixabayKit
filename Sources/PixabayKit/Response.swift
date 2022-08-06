//
//  Response.swift
//  
//
//  Created by Ethan Lipnik on 8/5/22.
//

import Foundation

struct Response<Item: Codable>: Codable {
    var hits: [Item]
}
