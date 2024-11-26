//
//  FileManagerDataCaching.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//


import Foundation

public actor FileManagerDataCaching {
    private let fileManager: FileManager
    private let cacheDirectoryURL: URL?
    
    public init(fileManager: FileManager = .default, cacheName: String = "DataCache") throws {
        self.fileManager = fileManager
        self.cacheDirectoryURL = try FileManagerDataCaching.cacheDirectoryURL(fileManager: fileManager, dataCacheName: cacheName)
    }
    
    public func cache(data: Data, using url: URL) async {
        guard let cacheDirectoryURL = cacheDirectoryURL else { return }
        
        let hashedFileName = url.hashedName()
        let fileURL = cacheDirectoryURL.appendingPathComponent(hashedFileName)
        
        fileManager.createFile(atPath: fileURL.path(), contents: data)
    }
    
    public func fetch(using url: URL) async -> Data? {
        guard let filePath = filePath(url: url) else { return nil }
        
        if fileManager.fileExists(atPath: filePath) {
            return fileManager.contents(atPath: filePath)
        }
        
        return nil
    }
    
    public func clearCache() async throws {
        guard let cacheDirectoryURL else { return }
        
        let fileURLs = try fileManager.contentsOfDirectory(at: cacheDirectoryURL, includingPropertiesForKeys: nil, options: [])
        for fileURL in fileURLs {
            try fileManager.removeItem(at: fileURL)
        }
    }
    
    public func filePath(url: URL) -> String? {
        let hashedFileName = url.hashedName()
        guard let cacheDirectoryURL else { return nil }
        return cacheDirectoryURL.appendingPathComponent(hashedFileName).path()
    }
    
    static func cacheDirectoryURL(fileManager: FileManager, dataCacheName: String) throws -> URL? {
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let imageCacheDirectory = cachesDirectory.appendingPathComponent(dataCacheName)
        
        if !fileManager.fileExists(atPath: imageCacheDirectory.path) {
            try fileManager.createDirectory(at: imageCacheDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        
        return imageCacheDirectory
    }
}
