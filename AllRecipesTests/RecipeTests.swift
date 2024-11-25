//
//  AllRecipesTests.swift
//  AllRecipesTests
//
//  Created by Caleb on 11/25/24.
//

import Foundation
import Testing

@testable import AllRecipes

struct RecipeTests {
    
    @Test("Testing JSON Decoding Success", arguments: [
        Recipe.jsonStringFull,
        Recipe.jsonStringMinimum
    ])
    func decodeRecipe(jsonString: String) throws {
        let json = try #require(jsonString.data(using: .utf8))
        
        let recipe = try JSONDecoder().decode(Recipe.self, from: json)
        #expect(recipe != nil)
    }
    
    @Test("Testing JSON Decoding Failure", arguments: [
        Recipe.jsonStringBadPropertyKey,
        Recipe.jsonStringBadPropertyValue
    ])
    func decodeRecipeFail(jsonString: String) throws {
        let json = try #require(jsonString.data(using: .utf8))
        
        #expect(throws: DecodingError.self) {
            try JSONDecoder().decode(Recipe.self, from: json)
        }
    }
}


//MARK: Recipe JSON
private extension Recipe {
    static let jsonStringFull =
        """
        {
            "cuisine": "British",
            "name": "Bakewell Tart",
            "photo_url_large": "https://some.url/large.jpg",
            "photo_url_small": "https://some.url/small.jpg",
            "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
            "source_url": "https://some.url/index.html",
            "youtube_url": "https://www.youtube.com/watch?v=some.id"
        }
        """
    
    static let jsonStringMinimum =
        """
        {
            "cuisine": "British",
            "name": "Bakewell Tart",
            "uuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
        }
        """
    
    static let jsonStringBadPropertyKey =
        """
        {
            "Badcuisine": "British",
            "Badname": "Bakewell Tart",
            "Baduuid": "eed6005f-f8c8-451f-98d0-4088e2b40eb6",
        }
        """
    
    static let jsonStringBadPropertyValue =
        """
        {
            "cuisine": null,
            "name": 2,
            "uuid": "eed6005f-",
        }
        """
}
