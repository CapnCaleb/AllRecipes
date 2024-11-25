//
//  NetworkManager.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import Foundation

struct NetworkManager {
    static func performRequest<T: Decodable>(_ request: APIRequest, responseType: T.Type) async throws -> T {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body

        let (data, _) = try await URLSession.shared.data(for: urlRequest)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
