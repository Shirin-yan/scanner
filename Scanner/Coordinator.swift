//
//  Coordinator.swift
//  Scanner
//
//  Created by Shirin-Yan on 24.08.2024.
//

import SwiftUI

enum Page: Hashable {
    case cropper(images: [UIImage])
    case filter(images: [UIImage])
    case export(images: [UIImage])
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    @ViewBuilder
    func view(for page: Page) -> some View {
        switch page {
        case .cropper(let images):
            CropperView()
        case .filter(let images):
            FilterView()
        case .export(let images):
            ExportView()
        }
    }
    
    func navigateTo(_ page: Page) {
        path.append(page)
    }

    func navigateBack(tab: Int) {
        path.removeLast()
    }
    
    func popToRoot(tab: Int) {
        path.removeLast(path.count-1)
    }
}
