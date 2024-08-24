//
//  Page.swift
//  Scanner
//
//  Created by Shirin-Yan on 24.08.2024.
//

import UIKit

enum Page: Hashable {
    case cropper(images: [UIImage])
    case filter(images: [UIImage])
    case export(images: [UIImage])
}

