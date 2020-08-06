//
//  NetworkService.swift
//  Puzzl-iOS
//
//  Created by Artem Dudinski on 4/29/20.
//  Copyright © 2020 Denis Butyletskiy. All rights reserved.
//

import Foundation
import Alamofire

typealias Response<T: Codable> = (response: T?, error: ApiError?)

enum ApiErrorType {
    case noInternet
    case custom
}

struct ApiError: Error {
    var type: ApiErrorType
    var message: String?
    
    init(type: ApiErrorType, message: String? = nil) {
        self.type = type
        self.message = message
    }
    
    static let defaultError = ApiError(type: .custom, message: "Unknown error")
    static let defaultServerError = ApiError(type: .custom, message: "Something went wrong. Please, try again later")
    static let decodingError = ApiError(type: .custom, message: "Decoding error")
}

class NetworkService {
    static let shared = NetworkService()
    
    static let baseUrl = "https://api.joinpuzzl.com/mobile"
    
    let BASE_URL = NetworkService.baseUrl

    public func createRequest(_ url: URLConvertible, method: HTTPMethod, parameters: Parameters? = nil, encoding: ParameterEncoding, headers: HTTPHeaders? = getHeaders()) -> DataRequest {
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers)
    }
    
    public func handleRequest<T: Codable>(_ request: DataRequest, completion: @escaping (Response<T>) -> (), isBaseResponse: Bool = true) {
        request.validate()
            .responseData { (response) in self.handleResponse(response, completion: completion, isBaseResponse: isBaseResponse) }
    }
    
    public func handleRequestWithErrorComletion(_ request: DataRequest, completion: @escaping (Error?) -> ()) {
        request.validate()
            .responseData { (response) in completion(response.error) }
    }
    
    private func handleResponse<T: Codable>(_ response: DataResponse<Data>, completion: @escaping (Response<T>) -> (), isBaseResponse: Bool) {
        if let error = response.error {
            let code = (error as NSError).code
            if code == NSURLErrorNotConnectedToInternet {
                completion(Response(response: nil, error: ApiError(type: .noInternet)))
                return
            } else {
                guard let jsonData = response.data else {
                    print("JSON ERROR")
                    completion(Response(response: nil, error: .defaultError))
                    return
                }
                completion(Response(response: nil, error: ApiError(type: .custom, message: "API ERROR")))
                return
            }
        }
        guard let jsonData = response.data else {
            completion(Response(response: nil, error: .defaultError))
            return
        }
        do {
            if isBaseResponse {
                let response = try JSONDecoder().decode(BaseResponse<T>.self, from: jsonData)
                guard let decodedResponse = response.data else {
                    completion(Response(response: nil, error: ApiError(type: .custom, message: "ERROR DECODING")))
                    return
                }
                completion(Response(response: decodedResponse, error: nil))
            } else {
                let response = try JSONDecoder().decode(T.self, from: jsonData)
                completion(Response(response: response, error: nil))
            }
        } catch let decodingError {
            print("----------------------")
            print("Decoding Error: \(decodingError)")
            print("----------------------")
            completion(Response(response: nil, error: ApiError(type: .custom, message: "Error using API")))
            return
        }
    }
    
    public func createQuery(to baseUrl: String, parameters: [String: String] = [:]) throws -> String {
        var query = [URLQueryItem]()
        for (key, value) in parameters {
            query.append(URLQueryItem(name: key, value: value))
        }
        guard var urlComponents = URLComponents(string: baseUrl) else {
            throw ApiError.defaultError
        }
        urlComponents.queryItems = query
        guard let url = urlComponents.url?.absoluteString else {
            throw ApiError.defaultError
        }
        return url
    }
    
    public static func getHeaders() -> HTTPHeaders {
        return ["Authorization" : "Bearer \(Puzzl.apiKey)"]
    }
    
    public static func getUploadHeaders() -> HTTPHeaders {
        return ["Content-Type" : "image/jpeg"]
    }
}

