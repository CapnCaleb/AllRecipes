//
//  RecipeAPIProtocol.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//

protocol RecipeAPIProtocol {
    func getRecipes() async throws -> RecipeResponse
    func getMalformedRecipes() async throws -> RecipeResponse
    func getEmptyRecipes() async throws -> RecipeResponse
}
