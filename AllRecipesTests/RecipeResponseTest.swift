//
//  RecipesTests.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import Foundation
import Testing

@testable import AllRecipes

class RecipeResponseTests {
    //MARK: Testing Success
    @Test("JSON Decoding Success", arguments: [
        RecipeResponse.jsonStringFull,
        RecipeResponse.jsonStringMinimum
    ])
    func decodeRecipe(jsonString: String) throws {
        let json = try #require(jsonString.data(using: .utf8))
        
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: json)
        #expect(recipeResponse.recipes.count > 0)
    }
    
    @Test("Good Demo Response Success")
    func decodeGoodDemoResponse() throws {
        let bundle = Bundle(for: RecipeResponseTests.self)
        let path = bundle.path(forResource: "GoodResponse", ofType: "json")!
        let url = URL(filePath: path, directoryHint: .inferFromPath)
        let data = try Data(contentsOf: url)
        
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
        #expect(!recipeResponse.recipes.isEmpty)
    }
    
    @Test("Empty Demo Response Success")
    func decodeEmptyDemoResponse() throws {
        let bundle = Bundle(for: RecipeResponseTests.self)
        let path = bundle.path(forResource: "EmptyResponse", ofType: "json")!
        let url = URL(filePath: path, directoryHint: .inferFromPath)
        let data = try Data(contentsOf: url)
        
        let recipeResponse = try JSONDecoder().decode(RecipeResponse.self, from: data)
        #expect(recipeResponse.recipes.isEmpty)
    }
    
    //MARK: Testing Failure
    @Test("JSON Decoding Failure", arguments: [
        RecipeResponse.jsonStringBadKey,
        RecipeResponse.jsonStringBadValue
    ])
    func decodeRecipeFailure(jsonString: String) throws {
        let json = try #require(jsonString.data(using: .utf8))
        
        
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(RecipeResponse.self, from: json)
        }
    }
    
    @Test("Malformed Response Failure")
    func decodeBadResponse() throws {
        let bundle = Bundle(for: RecipeResponseTests.self)
        let path = bundle.path(forResource: "MalformedResponse", ofType: "json")!
        let url = URL(filePath: path, directoryHint: .inferFromPath)
        let data = try Data(contentsOf: url)
        
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(RecipeResponse.self, from: data)
        }
    }
}

//MARK: RecipeResponse JSON
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
