//
//  CachedImageServiceTests.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//

import Foundation
import Testing
@testable import AllRecipes

struct CachedImageServiceTests {
    
    @Test("Testing failure to cache image", arguments: [
        URL(string: "www.example.com/shouldn't exist"),
        nil
    ])
    func badURLTest(url: URL?) async {
        let image = try? await CachedImageService.shared.getImage(for: url)
        #expect(image == nil)
    }
}
