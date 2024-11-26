//
//  EndpointMenu.swift
//  AllRecipes
//
//  Created by Caleb on 11/26/24.
//
import SwiftUI

struct EndpointMenu: View {
    @Binding var selectedOption: RecipeListViewModel.EndpointOption

    var body: some View {
        Menu {
            ForEach(RecipeListViewModel.EndpointOption.allCases, id: \.self) { option in
                Button {
                    selectedOption = option
                } label: {
                    Text(option.title)
                }
            }
        } label: {
            Text(selectedOption.title)
        }
    }
}
