//
//  FilterView.swift
//  Scanner
//
//  Created by Shirin-Yan on 24.08.2024.
//

import SwiftUI

enum Filter {
    static let allCases: [Filter] = [.original, .whiteBlack]
    
    case original
    case whiteBlack
    
    var title: String {
        switch self {
        case .original:
            return "Original"
        case .whiteBlack:
            return "WB"
        }
    }
}

struct FilterView: View {
    @EnvironmentObject var coordinator: Coordinator
    
    @State var images: [UIImage]
    @State var appliedImagies: [UIImage?]
    @State var selectedImg = 0
    
    @State var filters: [Filter] = [.original, .original, .original]
    @State var intensities: [CGFloat] = [0, 0, 0]

    init(images: [UIImage]) {
        self.images = images
        self.appliedImagies = Array(repeating: nil, count: images.count)
    }
    var body: some View {
        VStack(spacing: 10) {
            HeaderView(title: "Filter")

            TabView(selection: $selectedImg) {
                    ForEach(images.indices, id: \.self){ ind in
                        Image(uiImage: appliedImagies[ind] ?? images[ind])
                            .resizable()
                            .scaledToFit()
                            .padding()
                            .tag(ind)
                    }
                }.tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            
            Spacer()

            HStack(spacing:20) {
                ForEach(Filter.allCases, id: \.self){ filter in
                    filterBtn(filter, isSelected: filter == filters[selectedImg])
                }
            }
            
            if filters[selectedImg] == .whiteBlack {
                Slider(value: $intensities[selectedImg], in: -2.0...2.0)
                    .onChange(of: intensities[selectedImg]) { _ in
                        appliedImagies[selectedImg] = images[selectedImg].applyWhiteBlackFilter(intensity: intensities[selectedImg])
                    }
                    .padding(.horizontal, 20)
                    .frame(height: 80)
                    
            } else {
                Spacer(minLength: 80)
            }
            
            PrimaryBtnView(title: "CONTINUE") {
                coordinator.navigateTo(.export(images: appliedImagies.enumerated().map({$1 ?? images[$0]})))
            }.padding(.horizontal, 20)

        }.navigationBarBackButtonHidden()
    }
    
    @ViewBuilder func filterBtn(_ filter: Filter, isSelected: Bool) -> some View {
        VStack {
            Image(uiImage:images[selectedImg])
                .resizable()
                .scaledToFill()
                .frame(width: 56, height: 56, alignment: .center)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(isSelected ? Color.gradientColor1 : Color.clear, lineWidth: 2))
            Text(filter.title)
                .foregroundColor(.titleColor)
                .font(.med_16)
        }.onTapGesture {
            filters[selectedImg] = filter
            if filter == .original {
                appliedImagies[selectedImg] = nil
            } else if filter == .whiteBlack {
                appliedImagies[selectedImg] = images[selectedImg].applyWhiteBlackFilter(intensity: intensities[selectedImg])
            }
        }
    }
}

#Preview {
    FilterView(images: [UIImage(resource: ImageResource(name: "gradient-bg", bundle: .main)), UIImage(resource: ImageResource(name: "logo", bundle: .main)), UIImage(resource: ImageResource(name: "gradient-bg", bundle: .main))])
}
