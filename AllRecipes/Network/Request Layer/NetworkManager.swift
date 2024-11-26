//
//  NetworkManager.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import Foundation

struct NetworkManager {
    static func performRequest(_ request: APIRequest) async throws -> Data {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body
        
        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return data
    }
    
    static func performRequest<T: Decodable>(_ request: APIRequest, responseType: T.Type) async throws -> T {
        let data = try await performRequest(request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
