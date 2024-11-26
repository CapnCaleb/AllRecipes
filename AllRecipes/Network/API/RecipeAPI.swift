//
//  UserAPI.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import Foundation

struct RecipeAPI {
    private static let baseURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    private static let baseURLForMalformedData = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json")!
    private static let baseURLForEmptyData = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json")!

    static func getRecipes() async throws -> RecipeResponse {
        let request = DefaultAPIRequest(url: RecipeAPI.baseURL, method: .get)
        return try await NetworkManager.performRequest(request, responseType: RecipeResponse.self)
    }
    
    static func getEmptyRecipes() async throws -> RecipeResponse {
        let request = DefaultAPIRequest(url: RecipeAPI.baseURLForEmptyData, method: .get)
        return try await NetworkManager.performRequest(request, responseType: RecipeResponse.self)
    }
    
    static func getMalformedRecipes() async throws -> RecipeResponse {
        let request = DefaultAPIRequest(url: RecipeAPI.baseURLForMalformedData, method: .get)
        return try await NetworkManager.performRequest(request, responseType: RecipeResponse.self)
    }
}
