//
//  CropperListView.swift
//  Scanner
//
//  Created by Shirin-Yan on 24.08.2024.
//

import SwiftUI

struct CropperListView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    @State var images: [UIImage]
    @State var selectedImg = 0
    @State var isShowingCropper = false
    
    var body: some View {
        VStack(spacing: 10) {
            HeaderView(title: "Cropper")

            TabView(selection: $selectedImg) {
                    ForEach(images.indices, id: \.self){ ind in
                        Image(uiImage: images[ind])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .tag(ind)
                    }
                }.tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Spacer()
            
            PrimaryBtnView(title: "CROP") {
                isShowingCropper = true
            }.padding(.horizontal, 20)

            PrimaryBtnView(title: "CONTINUE") {
                coordinator.navigateTo(.filter(images: images))
            }.padding(.horizontal, 20)

        }.navigationBarBackButtonHidden()
            .sheet(isPresented: $isShowingCropper) {
                CropperView(image: images[selectedImg]) { croppedImg in
                    images[selectedImg] = croppedImg
                }.ignoresSafeArea()
                    .id(selectedImg)
            }
    }
}

#Preview {
    CropperListView(images: [UIImage(resource: ImageResource(name: "gradient-bg", bundle: .main)), UIImage(resource: ImageResource(name: "logo", bundle: .main)), UIImage(resource: ImageResource(name: "gradient-bg", bundle: .main))])
}
