//
//  Endpoint.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/9/22.
//

import Foundation

protocol Endpoint{
    
    //HTTP or HTTPS
    var scheme: String {get}
    
    //Base URL
    var baseURL: String {get}
    
    //Resource Path
    var path: String {get}
    
    //
    var parameters: [URLQueryItem] {get}
    
    //GET - POST
    var method: String {get}
}
