//
//  APIRequest.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import Foundation

protocol APIRequest {
    var url: URL { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
}
