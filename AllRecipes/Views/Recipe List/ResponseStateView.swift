//
//  ResponseStateView.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//
import SwiftUI

struct ResponseStateView: View {
    let isLoading: Bool
    let loadingError: Error?
    let recipeCount: Int

    var body: some View {
        if let _ = loadingError {
            Text("Something didn't load quite right.\nChange endpoint and try again.")
                .multilineTextAlignment(.center)
                .padding()
        } else if isLoading {
            ProgressView()
                .progressViewStyle(.circular)
        } else if recipeCount == 0 {
            Text("No Recipes. Yet!")
                .multilineTextAlignment(.center)
        }
    }
}
