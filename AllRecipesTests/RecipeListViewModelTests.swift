//
//  RecipeListViewModelTests.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//

import Testing
@testable import AllRecipes

struct RecipeListViewModelTests {
    @Test func testInitialState() {
        let viewModel = RecipeListViewModel(api: MockRecipeAPI(recipesResponse: nil, shouldThrowError: false))
        #expect(viewModel.recipes.count == 0, "No recipes should exist initially")
        #expect(viewModel.isLoading == false, "Loading should be false intially")
        #expect(viewModel.loadingError == nil, "No errors should exist initially")
        #expect(viewModel.recipeEndpointOption == .main, "Main Endpoint should be used initially")
    }
    
    @Test func fetchAllRecipeSuccess() async {
        let viewModel = RecipeListViewModel(api: MockRecipeAPI(recipesResponse: RecipeResponse(recipes: [Recipe(cuisine: "American", name: "Salad")]), shouldThrowError: false))
        await viewModel.fetchAllRecipes()
        
        #expect(viewModel.recipes.count == 1, "Should have 1 recipe")
        #expect(viewModel.recipes.first?.name == "Salad", "Name should match value in VM init")
        #expect(viewModel.recipes.first?.cuisine == "American", "Cuisine should match value in VM init")
        #expect(viewModel.loadingError == nil, "Data loaded, should not have an error")
        #expect(viewModel.isLoading == false, "Data should not be loading after await")
    }
    
    @Test func fetchMalformedAllRecipes() async {
        let viewModel = RecipeListViewModel(api: MockRecipeAPI(recipesResponse: nil, shouldThrowError: false))
        viewModel.recipeEndpointOption = .malformed
        await viewModel.fetchAllRecipes()
        
        #expect(viewModel.recipes.count == 0, "Should have 1 recipe")
        #expect(viewModel.recipes.first?.name == nil, "Name should match value in VM init")
        #expect(viewModel.recipes.first?.cuisine == nil, "Cuisine should match value in VM init")
        #expect(viewModel.loadingError != nil, "Data loaded, should not have an error")
        #expect(viewModel.isLoading == false, "Data should not be loading after await")
        #expect(viewModel.recipeEndpointOption == .malformed, "Main Endpoint should be used initially")
    }
    
    @Test func fetchEmptyAllRecipes() async {
        let viewModel = RecipeListViewModel(api: MockRecipeAPI(recipesResponse: nil, shouldThrowError: false))
        viewModel.recipeEndpointOption = .empty
        await viewModel.fetchAllRecipes()
        
        #expect(viewModel.recipes.count == 0, "No recipes should be returned")
        #expect(viewModel.isLoading == false, "Loading should be false after load completes")
        #expect(viewModel.loadingError == nil, "No errors should exist after load with no recipes")
        #expect(viewModel.recipeEndpointOption == .empty, "empty Endpoint should be set even after a failed load")
    }
}
