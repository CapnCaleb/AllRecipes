//
//  FileManagerDataCachingTests.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//

import Foundation
import Testing

@testable import AllRecipes

struct FileManagerDataCachingTests {
    private let cacheName = "MockCache"
    
    @Test("Testing inits for different init options")
    func initalSetup() async throws {
        let mockFileManager: MockFileManager = MockFileManager()
        let cache: FileManagerDataCaching = try FileManagerDataCaching(fileManager: mockFileManager, cacheName: cacheName)
        
        #expect(cache != nil)
        
        let cache2: FileManagerDataCaching = try FileManagerDataCaching(fileManager: mockFileManager)
        
        #expect(cache2 != nil)
    }
    
    @Test("Test Caching Data Success")
    func cachDataSuccess() async throws {
        let mockFileManager: MockFileManager = MockFileManager()
        let cache: FileManagerDataCaching = try FileManagerDataCaching(fileManager: mockFileManager, cacheName: cacheName)
        
        let testData = "Hello, Cache!".data(using: .utf8)!
        let testURL = URL(string: "https://example.com/resource1")!
        let filePath = await cache.filePath(url: testURL)!
        await cache.cache(data: testData, using: testURL)
        
        let cachedData = mockFileManager.files[filePath]
        
        #expect(cachedData == testData)
    }
    
    @Test("Test Fetching Data Success")
    func fetchDataSuccess() async throws {
        let mockFileManager: MockFileManager = MockFileManager()
        let cache: FileManagerDataCaching = try FileManagerDataCaching(fileManager: mockFileManager, cacheName: cacheName)
        
        let testData = "Hello, Fetch!".data(using: .utf8)!
        let testURL = URL(string: "https://example.com/resource2")!
        let filePath = await cache.filePath(url: testURL)
        
        mockFileManager.files[filePath!] = testData
        
        let fetchedData = await cache.fetch(using: testURL)
        
        #expect(testData == fetchedData)
    }
    
    @Test("Test Clearing Cache")
    func clearCache() async throws {
        let mockFileManager: MockFileManager = MockFileManager()
        let cache: FileManagerDataCaching = try FileManagerDataCaching(fileManager: mockFileManager, cacheName: cacheName)
        
        let testData = "Hello, Clear!".data(using: .utf8)!
        let testURL = URL(string: "https://example.com/resource3")!
        
        await cache.cache(data: testData, using: testURL)
        let fetchedFile = await cache.fetch(using: testURL)
        #expect(fetchedFile != nil)
        
        try await cache.clearCache()
        let fetchedFile2 = await cache.fetch(using: testURL)
        #expect(fetchedFile2 == nil)
    }
}
