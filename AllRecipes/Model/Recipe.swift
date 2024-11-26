//
//  Recipe.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import Foundation

struct Recipe: Decodable, Identifiable {
    let cuisine: String
    let name: String
    let uuid: UUID
    
    let photoURLLarge: URL?
    let photoURLSmall: URL?
    let sourceURL: URL?
    let youtubeURL: URL?
    
    var id: String {
        uuid.uuidString
    }
    
    init(cuisine: String, name: String, uuid: UUID = UUID()) {
        self.cuisine = cuisine
        self.name = name
        self.uuid = uuid
        
        self.photoURLLarge = nil
        self.photoURLSmall = nil
        self.sourceURL = nil
        self.youtubeURL = nil
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.cuisine = try container.decode(String.self, forKey: .cuisine)
        self.name = try container.decode(String.self, forKey: .name)
        self.uuid = try container.decode(UUID.self, forKey: .uuid)
        self.photoURLLarge = try? container.decodeIfPresent(URL.self, forKey: .photoURLLarge)
        self.photoURLSmall = try? container.decodeIfPresent(URL.self, forKey: .photoURLSmall)
        self.sourceURL = try? container.decodeIfPresent(URL.self, forKey: .sourceURL)
        self.youtubeURL = try? container.decodeIfPresent(URL.self, forKey: .youtubeURL)
    }
    
    enum CodingKeys: String, CodingKey {
        case cuisine
        case name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case uuid
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}
