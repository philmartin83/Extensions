//
//  JSONCodeableExtension.swift
//  Created by Phil Martin on 09/09/2019.
//  Copyright © 2019 Phil Martin. All rights reserved.
//

import Foundation

extension JSONDecoder{
    
   func decoderWithURLString<T: Decodable> (_ type: T.Type, fromURL url: String, completion: @escaping (Result<T, Error>) -> Void){
        let url = URL(string: url)
        // we can force unwrap the url  here becasue the URL should never be wrong if it is we need to crash or you could add a 'fatalError' and return a message
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            // if the response is good then decode to our object else return the error
            if let data = data{
                do {
                    // try to decode the repsonse
                    print(String(data: data, encoding: .utf8)!)
                    let decode = JSONDecoder()
                    let result = try decode.decode(type, from: data)
                    completion(.success(result)) // send back the object on completion
                } catch let error{
                    // if the try fails send the error (Can be used in an UIAlertController keeping UI away from networking :) )
                    completion(.failure(error))
                }
            }
            
        }.resume()
    }
    
    func decoderWithRequest<T: Decodable> (_ type: T.Type, fromURLRequest urlRequest: URLRequest , completion: @escaping (Result<T, Error>) -> Void){
        // use the passed in URLRequest to make communication with the server, all the requred headers should be added prior to call this fucntion
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // get our response status code
            // if the response is good then decode to our object else return the error
            if let data = data{
                do {
                    // try to decode the repsonse
                    print(String(data: data, encoding: .utf8)!)
                    let decode = JSONDecoder()
                    let result = try decode.decode(type, from: data)
                    completion(.success(result)) // send back the object on completion
                } catch let error{
                    // if the try fails send the error (Can be used in an UIAlertController keeping UI away from networking :) )
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
