//
//  DogEndpoint.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/9/22.
//

import Foundation

enum DogEndpoint: Endpoint{
    case getAllBreeds
    case getAllImages(breed: String)
    case getRandomImage(breed: String)
    case getImagesBySubBreed(breed: String,subBreed: String)
    
    var scheme: String{
        switch self{
        default:
            return "https"
        }
    }
    
    var baseURL: String{
        switch self{
        default:
            return "dog.ceo"
        }
    }
    
    var path: String{
        switch self{
        case .getAllBreeds:
            return "/api/breeds/list/all"
        case let .getAllImages(breed):
            return "/api/breed/\(breed)/images"
        case let .getRandomImage(breed):
            return "/api/breed/\(breed)/images/random"
        case let .getImagesBySubBreed(breed, subBreed):
            return "/api/breed/\(breed)/\(subBreed)/images"
        }
    }
    
    var parameters: [URLQueryItem]{
        switch self{
        default:
            return []
        }
    }
    
    var method: String{
        switch self {
        default:
            return "GET"
        }
    }
    
}
