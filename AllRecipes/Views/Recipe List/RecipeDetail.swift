//
//  RecipeDetail.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import SwiftUI

struct RecipeDetail: View {
    let recipe: Recipe
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 32) {
                LoadingImageView(url: recipe.photoURLLarge)
                    .overlay(alignment: .topLeading) {
                        Text(recipe.cuisine)
                            .foregroundStyle(.white)
                            .font(.headline)
                            .padding(.all)
                    }
                    .aspectRatio(1, contentMode: .fit)
                
                if let youtubeURL = recipe.youtubeURL {
                    Link(destination: youtubeURL) {
                        Text("Watch on YouTube")
                    }
                }
                
                if let sourceURL = recipe.sourceURL {
                    Link(destination: sourceURL) {
                        Text("Visit Website")
                    }
                }
                
            }
            .padding(.horizontal)
        }
        .navigationTitle(recipe.name)
    }
}
