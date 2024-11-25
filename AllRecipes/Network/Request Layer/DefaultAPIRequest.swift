//
//  DefaultAPIRequest.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import Foundation

struct DefaultAPIRequest: APIRequest {
    let url: URL
    let method: HTTPMethod
    let headers: [String: String]?
    let body: Data?

    init(url: URL, method: HTTPMethod, headers: [String: String]? = nil, body: Data? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.body = body
    }
}
