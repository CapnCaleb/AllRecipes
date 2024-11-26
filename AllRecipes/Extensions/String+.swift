//
//  String+.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//
import CryptoKit
import Foundation

public extension String {
    func sha256() -> String {
        let data = Data(self.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}
