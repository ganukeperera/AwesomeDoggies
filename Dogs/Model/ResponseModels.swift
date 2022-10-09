//
//  ResponseModels.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/9/22.
//

import Foundation


struct ImageResponse: Codable {
    let status: String
    let message: [String]
}

struct BreedResponse: Codable {
    let status: String
    let message: [String:[String]]
    
}
