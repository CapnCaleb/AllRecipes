//
//  FileManagerImageCaching.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import UIKit

public actor FileManagerImageCaching {
    private let fileManager: FileManager
    private let cacheDirectoryURL: URL?
    
    public init(cacheName: String = "ImageCache") {
        fileManager = FileManager.default
        cacheDirectoryURL = FileManagerImageCaching.cacheDirectoryURL(fileManager: FileManager.default, imageCacheSubdirectory: cacheName)
    }
    
    public func cache(image: UIImage, using url: URL) async {
        guard let cacheDirectoryURL = cacheDirectoryURL else {
            return
        }
        
        let hashedFileName = getHashedName(with: url)
        let fileURL = cacheDirectoryURL.appendingPathComponent(hashedFileName)
        
        
        switch url.pathExtension {
        case "png":
            guard let imageData = image.pngData() else { return }
            await writeImage(imageData: imageData, fileURL: fileURL)
        default:
            guard let imageData = image.jpegData(compressionQuality: 1.0) else {
                print("Failed to convert UIImage to Data")
                return
            }
            await writeImage(imageData: imageData, fileURL: fileURL)
        }
        
        
        func writeImage(imageData: Data, fileURL: URL) async {
            do {
                try imageData.write(to: fileURL)
            } catch {
                print("Error caching image in file manager: \(error)")
            }
        }
    }
    
    public func fetch(using url: URL) async -> UIImage? {
        guard let cacheDirectoryURL = cacheDirectoryURL else {
            return nil
        }
        
        let hashedFileName = getHashedName(with: url)
        
        let fileURL = cacheDirectoryURL.appendingPathComponent(hashedFileName)
        
        if fileManager.fileExists(atPath: fileURL.path) {
            if let imageData = try? Data(contentsOf: fileURL) {
                return UIImage(data: imageData)
            }
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
    
    private static func cacheDirectoryURL(fileManager: FileManager, imageCacheSubdirectory: String) -> URL? {
        guard let cachesDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let imageCacheDirectory = cachesDirectory.appendingPathComponent(imageCacheSubdirectory)
        
        if !fileManager.fileExists(atPath: imageCacheDirectory.path) {
            do {
                try fileManager.createDirectory(at: imageCacheDirectory, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("Error creating image cache directory: \(error)")
                return nil
            }
        }
        
        return imageCacheDirectory
    }
    
    private func getHashedName(with url: URL) -> String {
        url.absoluteString.sha256()
    }
}
