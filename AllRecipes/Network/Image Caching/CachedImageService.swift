//
//  CachedImageService.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import UIKit

public actor CachedImageService {
    static let shared = CachedImageService()
    private var iconCache = [String : UIImage]()
    private var cachedItemNames = [String]()
    private let fileManagerCache: FileManagerDataCaching
    private let cacheItemLimit: Int
    
    public init(cacheItemLimit: Int = 50) {
        self.cacheItemLimit = cacheItemLimit
        self.fileManagerCache = try! FileManagerDataCaching()
    }
    
    public func getImage(for url: URL?) async throws -> UIImage? {
        guard let url else { return nil }
        
        return try await fetchImage(using: url)
    }
}

//MARK: Fetching
extension CachedImageService {
    private func fetchImage(using url: URL) async throws -> UIImage? {
        if let image = await fetchFromDictionary(with: url) {
            return image
        }
        
        if let data = await fileManagerCache.fetch(using: url), let image = UIImage(data: data) {
            await cacheImageInDictionary(url: url, image: image)
            return image
        }

        if let image = try await fetchRemoteImage(using: url) {
            await cacheImageInDictionary(url: url, image: image)
            if let imageData = image.jpegData(compressionQuality: 1.0) {
                await fileManagerCache.cache(data: imageData, using: url)
            }
            return image
        }
        
        return nil
    }
    
    private func fetchFromDictionary(with url: URL) async -> UIImage? {
        return self.iconCache[url.hashedName()]
    }
    
    private func fetchRemoteImage(using url: URL) async throws -> UIImage? {
        let request = DefaultAPIRequest(url: url, method: .get)
        let data = try await NetworkManager.performRequest(request)
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
}

//MARK: Caching
extension CachedImageService {
    private func cacheImageInDictionary(url: URL, image: UIImage) async {
        let hashedName = url.hashedName()
        self.iconCache[hashedName] = image
        await manageCache(hashName: hashedName)
    }
    
    private func manageCache(hashName: String) async {
        cachedItemNames.insert(hashName, at: 0)
        guard cachedItemNames.count >= cacheItemLimit else { return }
        guard let oldestItem = cachedItemNames.popLast() else { return }
        iconCache[oldestItem] = nil
    }
}

