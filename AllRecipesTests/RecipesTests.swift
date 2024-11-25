//
//  RecipesTests.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import Foundation
import Testing

@testable import AllRecipes

struct RecipeResponseTests {
    
    @Test("Testing JSON Decoding Success", arguments: [
        RecipeResponse.jsonStringFull,
        RecipeResponse.jsonStringMinimum
    ])
    func decodeRecipe(jsonString: String) throws {
        let json = try #require(jsonString.data(using: .utf8))
        
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: json)
        #expect(recipeResponse.recipes.count > 0)
    }
    
    @Test("Testing JSON Decoding Failure", arguments: [
        RecipeResponse.jsonStringBadKey,
        RecipeResponse.jsonStringBadValue
    ])
    func decodeRecipeFailure(jsonString: String) throws {
        let json = try #require(jsonString.data(using: .utf8))
        
        
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(RecipeResponse.self, from: json)
        }
    }
}

//MARK: Recipe RecipeResponse
private extension RecipeResponse {
    static let jsonStringFull =
    """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photo_url_large": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
                },
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "photo_url_large": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
                }
            ]
        }
    """
    
    static let jsonStringMinimum =
    """
        {
            "recipes": [
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                },
                {
                    "cuisine": "British",
                    "name": "Bakewell Tart",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb7",
                }
            ]
        }
    """
    
    static let jsonStringBadKey =
    """
        {
            "recipes": [
                {
                    "Badcuisine": "British",
                    "Badname": "Bakewell Tart",
                    "photo_url_large": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "Baduuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
                }
            ]
        }
    """
    
    static let jsonStringBadValue =
    """
        {
            "recipes": [
                {
                    "cuisine": 2,
                    "name": Bakewell Tart,
                    "photo_url_large": "https://some.url/large.jpg",
                    "photo_url_small": "https://some.url/small.jpg",
                    "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
                    "source_url": "https://some.url/index.html",
                    "youtube_url": "https://www.youtube.com/watch?v=some.id"
                }
            ]
        }
    """
}
