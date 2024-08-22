//
//  Color.swift
//  Scanner
//
//  Created by Shirin-Yan on 22.08.2024.
//

import SwiftUI

extension Color {
    static let gradientColor1 = Color(hex: 0x6CD3FF)
    static let gradientColor2 = Color(hex: 0x555CFF)
    static let titleColor = Color(hex: 0x6A79B7)
}

extension Color {
    init(hex: Int) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
