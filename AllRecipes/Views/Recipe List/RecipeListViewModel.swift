//
//  RecipeListViewModel.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//
import SwiftUI

final class RecipeListViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var loadingError: Error?
    @Published var recipeEndpointOption: EndpointOption = .main

    private let api: RecipeAPIProtocol
    
    init(api: RecipeAPIProtocol = RecipeAPI()) {
        self.api = api
    }
    
    enum EndpointOption: String, CaseIterable {
        case main, malformed, empty

        var title: String { rawValue.capitalized }
    }

    func fetchAllRecipes() {
        guard !isLoading else { return }
        isLoading = true
        Task {
            do {
                let recipeResponse: RecipeResponse = try await {
                    switch recipeEndpointOption {
                    case .main: return try await api.getRecipes()
                    case .malformed: return try await api.getMalformedRecipes()
                    case .empty: return try await api.getEmptyRecipes()
                    }
                }()
                await MainActor.run {
                    self.recipes = recipeResponse.recipes
                    self.loadingError = nil
                }
            } catch {
                await MainActor.run {
                    self.recipes = []
                    self.loadingError = error
                }
            }
            await MainActor.run {
                self.isLoading = false
            }
        }
    }
}
