//
//  RecipeList.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import SwiftUI

struct RecipeList: View {
    @State private var recipes: [Recipe] = []
    @State private var loadingState: LoadingState = .loading
    
    var body: some View {
        NavigationStack {
            List(recipes) { recipe in
                NavigationLink {
                    RecipeDetail(recipe: recipe)
                } label: {
                    RecipeItem(recipe: recipe)
                }

            }
            .refreshable {
                await fetchAllRecipes()
            }
            .overlay(alignment: .bottomTrailing, content: {
                RefreshButton {
                    await fetchAllRecipes()
                }
                .padding(.horizontal)
            })
            .navigationTitle("All Recipes")
            .task {
                await fetchAllRecipes()
            }
        }
    }
    
    enum LoadingState {
        case loading
        case failure
        case complete
    }
}

extension RecipeList {
    func fetchAllRecipes() async {
        await MainActor.run { loadingState = .loading }
        do {
            let recipeResponse = try await RecipeAPI.getRecipes()
            await MainActor.run {
                recipes = recipeResponse.recipes
                loadingState = .complete
            }
        } catch {
            await MainActor.run { loadingState = .failure }
        }
    }
    
    
}
