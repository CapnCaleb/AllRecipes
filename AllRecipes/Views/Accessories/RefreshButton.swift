//
//  RefreshButton.swift
//  AllRecipes
//
//  Created by Caleb on 11/25/24.
//

import SwiftUI

struct RefreshButton: View {
    @State var isLoading: Bool = false
    @State private var rotationEffect: Double = 0
    
    let action: (() -> Void)?
    let asyncAction: (() async -> Void)?
    
    init(action: @escaping () -> Void) {
        self.action = action
        self.asyncAction = nil
    }
    
    init(asyncAction: @escaping () async -> Void) {
        self.action = nil
        self.asyncAction = asyncAction
    }
    
    var body: some View {
        Button(action: {
            handleAction()
        }, label: {
            if isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
                    .foregroundStyle(.white)
                    .frame(width: 54, height: 54)
            } else {
                Image(systemName: "arrow.circlepath")
                    .font(.largeTitle)
                    .foregroundStyle(.white)
                    .rotationEffect(.degrees(rotationEffect))
                    .rotation3DEffect(
                        .degrees(180),
                        axis: (x: 0, y: 1, z: 0)
                    )
                    .padding(8)
            }
        })
        .background(.blue.gradient)
        .frame(width: 54, height: 54)
        .clipShape(Circle())
        .disabled(isLoading)
        .shadow(radius: 8)
    }
    
    private func handleAction() {
            withAnimation {
                rotationEffect -= 360
            } completion: {
                if let asyncAction {
                    withAnimation { isLoading = true }
                    Task {
                        await asyncAction()
                        await MainActor.run {
                            withAnimation { isLoading = false }
                        }
                    }
                } else {
                    action?()
                }
            }
    }
}

#Preview {
    RefreshButton {
        do { try await Task.sleep(for: .seconds(5)) }
        catch { print(error) }
    }
}
