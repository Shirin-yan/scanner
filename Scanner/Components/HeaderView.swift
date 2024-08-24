//
//  HeaderView.swift
//  Scanner
//
//  Created by Shirin-Yan on 24.08.2024.
//

import SwiftUI

struct HeaderView: View {
    @EnvironmentObject var coordinator: Coordinator
    var title: String
    
    var body: some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .foregroundColor(.white)
            .font(.med_20)
            .frame(height: 50)
            .overlay(alignment: .leading, content: {
                Button {
                    coordinator.navigateBack()
                } label: {
                    Image(systemName: "chevron.left")
                        .imageScale(.large)
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40, alignment: .center)
                }.padding(.leading, 10)
            }).background(
                LinearGradient(colors: [.gradientColor1, .gradientColor2], startPoint: .leading, endPoint: .trailing)
                    .ignoresSafeArea()
            )
    }
}

#Preview {
    VStack {
        HeaderView(title: "QWERTY")
        
        Spacer()
    }
}
