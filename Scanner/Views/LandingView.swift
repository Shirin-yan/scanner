//
//  LandingView.swift
//  Scanner
//
//  Created by Shirin-Yan on 22.08.2024.
//

import SwiftUI

struct LandingView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    @State var isScannerPresented = false
    
    var body: some View {
        VStack {
            Image("gradient-bg")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity)
                .ignoresSafeArea()
            
            Spacer()

            VStack(spacing: 20) {
                LinearGradient(
                    colors: [.gradientColor1, .gradientColor2],
                    startPoint: .leading,
                    endPoint: .trailing
                ).mask(
                    Text("Portable application.")
                        .font(.bold_30)
                        .multilineTextAlignment(.center)
                ).frame(maxHeight: 40)

                Text("Take it with you everywhere!")
                    .font(.med_20)
                    .foregroundColor(.titleColor)
                    .multilineTextAlignment(.center)
            }
            
            Spacer()
            
            Spacer()
            
            PrimaryBtnView(title: "NEXT") {
                isScannerPresented.toggle()
            }.padding()
            
            HStack {
                Link(destination: URL(string: "https://www.apple.com/legal/privacy/en-ww/")!, label: {
                    Text("Terms of Service")
                        .font(.bold_12)
                        .foregroundColor(.titleColor)
                })
                
                Rectangle()
                    .fill(Color.titleColor)
                    .frame(width: 1, height: 16)
                
                Link(destination: URL(string: "https://www.apple.com/legal/internet-services/terms/site.html")!, label: {
                    Text("Privacy Policy")
                        .font(.bold_12)
                        .foregroundColor(.titleColor)
                })
            }
        }.fullScreenCover(isPresented: $isScannerPresented) {
            DocumentScannerView(isPresented: $isScannerPresented) { scannedImgs in
                if !scannedImgs.isEmpty {
                    coordinator.navigateTo(.cropper(images: scannedImgs))
                }
            }.ignoresSafeArea()
        }

    }
}

#Preview {
    LandingView()
}
