//
//  CropperView.swift
//  Scanner
//
//  Created by Shirin-Yan on 24.08.2024.
//

import SwiftUI

struct CropperView: View {
    @State var images: [UIImage]

    var body: some View {
        VStack {
            
            
            ScrollView(.horizontal) {
                LazyHStack {
//                    ForEach(images.indices, id: \.self){ ind in
//                        
//                    }
                }
            }
        }.navigationBarBackButtonHidden()
    }
}

//#Preview {
//    CropperView()
//}
