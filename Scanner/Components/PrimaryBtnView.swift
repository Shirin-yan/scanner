//
//  PrimaryBtnView.swift
//  Scanner
//
//  Created by Shirin-Yan on 24.08.2024.
//

import SwiftUI

struct PrimaryBtnView: View {
    var title: String
    var onClick: () -> ()
    
    var body: some View {
        Button{
            onClick()
        } label: {
            Text(title)
                .font(.med_20)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.all, 14)
                .background(LinearGradient(
                    colors: [.gradientColor1, .gradientColor2],
                    startPoint: .leading,
                    endPoint: .trailing
                ))
                .cornerRadius(30)
        }
    }
}
