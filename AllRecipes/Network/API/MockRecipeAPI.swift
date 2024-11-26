//
//  MockRecipeAPI.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//

import Foundation

struct MockRecipeAPI: RecipeAPIProtocol {
    var recipesResponse: RecipeResponse?
    var shouldThrowError: Bool = false

    func getRecipes() async throws -> RecipeResponse {
        if shouldThrowError { throw URLError(.badServerResponse) }
        return recipesResponse ?? RecipeResponse(recipes: [])
    }

    func getMalformedRecipes() async throws -> RecipeResponse {
        throw URLError(.cannotParseResponse)
    }

    func getEmptyRecipes() async throws -> RecipeResponse {
        return RecipeResponse(recipes: [])
    }
}
