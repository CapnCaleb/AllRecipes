//
//  RecipeList.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import SwiftUI

struct RecipeList: View {
    @StateObject private var viewModel = RecipeListViewModel()

    var body: some View {
        NavigationStack {
            VStack {
                recipeList
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .bottomTrailing) {
                RefreshButton(action: viewModel.fetchAllRecipes)
                    .padding(.horizontal)
            }
            .overlay(alignment: .center) {
                ResponseStateView(isLoading: viewModel.isLoading,
                                  loadingError: viewModel.loadingError,
                                  recipeCount: viewModel.recipes.count)
            }
            .navigationTitle("All Recipes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EndpointMenu(selectedOption: $viewModel.recipeEndpointOption)
                }
            }
            .onChange(of: viewModel.recipeEndpointOption) { _, _ in
                viewModel.fetchAllRecipes()
            }
            .task {
                viewModel.fetchAllRecipes()
            }
        }
    }
    
    private var recipeList: some View {
        List(viewModel.recipes) { recipe in
            NavigationLink {
                RecipeDetail(recipe: recipe)
            } label: {
                RecipeItem(recipe: recipe)
            }
        }
        .listStyle(.plain)
        .refreshable {
            viewModel.fetchAllRecipes()
        }
    }
}
