//
//  ExportView.swift
//  Scanner
//
//  Created by Shirin-Yan on 24.08.2024.
//

import SwiftUI

struct ExportView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    @State var images: [UIImage]
    @State var selectedImg = 0
    
    @State var isLoading = false
    @State var pdfURL: URL?
    @State var isShareSheetPresented = false

    var body: some View {
        VStack(spacing: 10) {
            HeaderView(title: "Export")

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

            PrimaryBtnView(title: "RETAKE") {
                coordinator.popToRoot()
            }.padding(.horizontal, 20)

            PrimaryBtnView(title: "EXPORT AS PDF") {
                isLoading = true
                PdfHelper.exportImagesAsPdf(images: images){ url in
                    isLoading = false
                    self.pdfURL = url
                    isShareSheetPresented = true
                }
            }.padding(.horizontal, 20)
        }.navigationBarBackButtonHidden()
            .overlay(content: {
                if isLoading {
                    ProgressView("Creating PDF...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                }
            })
            .sheet(isPresented: $isShareSheetPresented) {
                if let pdfURL = pdfURL {
                    ShareSheet(items: [pdfURL])
                }
            }
    }
    
}

#Preview {
    ExportView(images: [UIImage(resource: ImageResource(name: "gradient-bg", bundle: .main)), UIImage(resource: ImageResource(name: "logo", bundle: .main)), UIImage(resource: ImageResource(name: "gradient-bg", bundle: .main))])
}
