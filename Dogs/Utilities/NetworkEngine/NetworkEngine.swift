//
//  NetworkEngine.swift
//  Dogs
//
//  Created by Ganuke Perera on 10/9/22.
//

import Foundation

class NetworkEngine{
    
    // This method can be used to process JSON data received from remote endpoint over http/https
    // JSON redponse will be mapped to povided Codable object model
    
    class func request<T:Codable>(endPoint: Endpoint, completion:@escaping (Result<T,Error>)->Void)->Void{
        
        let urlComponents = NSURLComponents()
        urlComponents.scheme = endPoint.scheme
        urlComponents.host = endPoint.baseURL
        urlComponents.path = endPoint.path
        urlComponents.queryItems = endPoint.parameters
        
        guard let url = urlComponents.url else{
            assertionFailure("URL generation failed for path \(endPoint.path)")
            return
        }
        
        // Using default configuration as this project sends simple requests
        // No need of using customized configurations as of now
        let session = URLSession(configuration: .default)
        let urlRequest = URLRequest(url: url)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard error == nil else{
                completion(.failure(error!))
                return
            }
            
            guard response != nil, let data = data else{
                let dict = [NSLocalizedDescriptionKey:"empty response"]
                let err = NSError(domain: "Network Engine", code: 200, userInfo: dict)
                completion(.failure(err))
                return
            }
            
            DispatchQueue.main.async {
                guard let responseObject = try? JSONDecoder().decode(T.self, from: data) else {
                    
                    let dict = [NSLocalizedDescriptionKey:"Failed when Dcoding"]
                    let err = NSError(domain: "Network Engine", code: 200, userInfo: dict)
                    completion(.failure(err))
                    return
                }
                
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
}
