//
//  MockFileManager.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//

import Foundation

final class MockFileManager: FileManager {
    var files: [String: Data] = [:]
    
    override func fileExists(atPath path: String) -> Bool {
        files[path] != nil
    }
    
    override func contents(atPath path: String) -> Data? {
        files[path]
    }
    
    override func createFile(atPath path: String, contents data: Data?, attributes: [FileAttributeKey: Any]? = nil) -> Bool {
        guard let data = data else { return false }
        files[path] = data
        return true
    }
    
    override func removeItem(at URL: URL) throws {
        files.removeValue(forKey: URL.path)
    }
    
    override func contentsOfDirectory(at url: URL, includingPropertiesForKeys keys: [URLResourceKey]?, options mask: FileManager.DirectoryEnumerationOptions = []) throws -> [URL] {
        return files.keys.compactMap { URL(string: $0) }
    }
}
