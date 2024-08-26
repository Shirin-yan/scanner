//
//  Coordinator.swift
//  Scanner
//
//  Created by Shirin-Yan on 24.08.2024.
//

import SwiftUI

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    @ViewBuilder
    func view(for page: Page) -> some View {
        switch page {
        case .cropper(let images):
            CropperListView(images: images)
        case .filter(let images):
            FilterView()
        case .export(let images):
            ExportView()
        }
    }
    
    func navigateTo(_ page: Page) {
        path.append(page)
    }

    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot(tab: Int) {
        path.removeLast(path.count-1)
    }
}
