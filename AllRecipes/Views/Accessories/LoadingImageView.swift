//
//  LoadingImageView.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import SwiftUI

struct LoadingImageView: View {
    let url: URL?
    
    @State private var viewState: ViewState = .loading
    
    var body: some View {
        VStack {
            switch viewState {
            case .loading:
                ProgressView()
                    .frame(width: 24, height: 24)
            case .failure:
                Image(systemName: "questionmark.square.dashed").resizable()
            case .complete(let image):
                Image(uiImage: image).resizable()
            }
        }
        .background(Color.gray.tertiary)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .task {
            await handleState(imageURL: url)
        }
    }
    
    enum ViewState {
        case loading
        case failure
        case complete(UIImage)
    }
}

extension LoadingImageView {
    func handleState(imageURL: URL?, retry: Bool = false) async {
        do {
            let image = try await loadImage(for: imageURL)
            guard let image else { await set(state: .failure); return }
            await set(state: .complete(image))
        } catch {
            await set(state: .failure)
        }
    }
    
    func loadImage(for url: URL?) async throws -> UIImage? {
        let image = try await CachedImageService.shared.getImage(for: url)
        return image
    }
    
    func set(state: ViewState) async {
        await MainActor.run {
            viewState = state
        }
    }
}
