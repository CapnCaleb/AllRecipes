//
//  RecipeItem.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import SwiftUI

struct RecipeItem: View {
    let recipe: Recipe
    @State private var imageData: Data?
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            VStack(alignment: .leading, spacing: 0) {
                makeTitleView(title: recipe.name)
                makeDescriptionView(description: recipe.cuisine)
            }
            
            if recipe.photoURLSmall != nil {
                LoadingImageView(url: recipe.photoURLSmall)
                    .frame(width: 80, height: 80)
            }
        }
    }
    
    @ViewBuilder
    func makeTitleView(title: String) -> some View {
        Text(title)
            .font(.system(size: 18, weight: .bold, design: .rounded))
            .lineLimit(2)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder
    func makeDescriptionView(description: String) -> some View {
        Text(description)
            .font(.system(size: 16, weight: .regular, design: .rounded))
            .lineLimit(1)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
