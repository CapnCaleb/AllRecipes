//
//  Recipe.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import Foundation

struct Recipe: Decodable {
    let cuisine: String
    let name: String
    private let photoURLLargeString: String?
    private let photoURLSmallString: String?
    let uuid: UUID
    private let sourceURLString: String?
    private let youtubeURLString: String?
    
    var imageURL: URL? {
        guard let photoURLLargeString else { return nil }
        return URL(string: photoURLLargeString)
    }
    
    var thumbnail: URL? {
        guard let photoURLSmallString else { return nil }
        return URL(string: photoURLSmallString)
    }
    
    var sourceURL: URL? {
        guard let sourceURLString else { return nil }
        return URL(string: sourceURLString)
    }
    
    var youtubeURL: URL? {
        guard let youtubeURLString else { return nil }
        return URL(string: youtubeURLString)
    }
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLargeString = "photo_url_large"
        case photoURLSmallString = "photo_url_small"
        case uuid
        case sourceURLString = "source_url"
        case youtubeURLString = "youtube_url"
    }
}
