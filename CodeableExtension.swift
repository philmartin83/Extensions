//
//  JSONCodeableExtension.swift
//  Created by Phil Martin on 09/09/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation

extension JSONDecoder{
    
    func decoderWithURLString<T: Decodable> (_ type: T.Type, fromURL url: String, completion: @escaping (T?, Error?) -> Void){
        let url = URL(string: url)
        // we can force unwrap the url  here becasue the URL should never be wrong if it is we need to crash or you could add a 'fatalError' and return a message
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            // if the response is good then decode to our object else return the error
            if let data = data, statusCode >= 200 && statusCode < 300{
                do {
                    // try to decode the response.
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(result, nil) // send back the good stuff :)
                } catch let error{
                    completion(nil, error)
                }
            }else{
                // don't return the objet and return the error response
                completion(nil, error)

            }
            
        }.resume()
    }
    
    func decoderWithRequest<T: Decodable> (_ type: T.Type, fromURLRequest urlRequest: URLRequest , completion: @escaping (T?, Error?) -> Void){
        // use the passed in URLRequest to make communication with the server, all the requred headers should be added prior to call this fucntion
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // get our response status code
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            // if the response is good then decode to our object else return the error
            if let data = data, statusCode >= 200 && statusCode < 300{
                do {
                    // try to decode the repsonse
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(result, nil) // send back the object on completion
                } catch let error{
                    // if the try fails send the error (Can be used in an UIAlertController keeping UI away from networking :) )
                    completion(nil, error)
                }
            }else{
                // its all gone wrong no network or server error :( SAD TIMES!!!!
                completion(nil, error)
            }
        }.resume()
    }
}
