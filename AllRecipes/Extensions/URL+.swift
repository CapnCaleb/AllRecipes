//
//  URL+.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//

import Foundation

extension URL {
    func hashedName() -> String {
        self.absoluteString.sha256()
    }
}
