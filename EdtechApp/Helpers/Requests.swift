//
//  Requests.swift
//  EdtechApp
//
//  Created by MATHIAS GAMMELGAARD on 21/05/2021.
//

import Foundation

var baseUrl = "http://localhost:5001/api/v1/";

enum RequestError: Error {
    case transportError(message: String)
    case serverError(message: String)
    
    public var localizedDescription: String? {
        switch self {
            case .transportError(message: let message):
                return "An unexpected error occured: \(message)"
            case .serverError(message: let message):
                return message
        }
    }
}

struct ServerError: Decodable {
    enum type: String, Decodable {
        case email, password, password2
    }

    let message: String
}

func escape(url: String) -> String {
    let allowedCharacters = url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
    return allowedCharacters!
}

func request(route: String, method: String, data: [String: String], completion: @escaping (Result<String, RequestError>) -> Void) {

    let url = URL(string:  escape(url: baseUrl + route))
    guard let requestUrl = url else { fatalError() }

    var request = URLRequest(url: requestUrl)
    request.httpMethod = method
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
    request.setValue( "", forHTTPHeaderField: "Authorization")
     
    if method == "POST" {
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.transportError(message: error.localizedDescription)))
                return
            }
     
            let response = response as! HTTPURLResponse
            if !(200...299).contains(response.statusCode) {
                switch response.statusCode {
                case 400:
                    if let serverError: ServerError = try? JSONDecoder().decode(ServerError.self, from: data!) {
                        completion(.failure(.serverError(message: serverError.message)))
                        return
                    }
                    
                    let dataString = String(data: data!, encoding: .utf8)
                    completion(.failure(.serverError(message: dataString!)))
                    return
                case 401:
                    completion(.failure(.serverError(message: "Unauthorized")))
                    return
                default:
                    completion(.failure(.serverError(message: "Unexpected error")))
                    return
                }
                
            }
        
            let dataString = String(data: data!, encoding: .utf8)
            completion(.success(dataString!))
            return
    }
    task.resume()
}

func post(route: String, data: [String: String], completion: @escaping (Result<String, RequestError>) -> Void) {
    request(route: route, method: "POST", data: data, completion: completion)
}

func get(route: String, completion: @escaping (Result<String, RequestError>) -> Void) {
    request(route: route, method: "GET", data: [:], completion: completion)
}
