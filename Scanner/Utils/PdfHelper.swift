//
//  PdfHelper.swift
//  Scanner
//
//  Created by Shirin-Yan on 26.08.2024.
//

import UIKit

class PdfHelper {

    static func exportImagesAsPdf(images: [UIImage], completion: @escaping (URL?)->() ) {
        let tempDirectory = FileManager.default.temporaryDirectory
        let pdfURL = tempDirectory.appendingPathComponent("ScannedDocument_\(UUID().uuidString.prefix(8)).pdf")
        
        do {
            try UIGraphicsPDFRenderer().writePDF(to: pdfURL) { context in
                for image in images {
                    let imageBounds = CGRect(origin: .zero, size: image.size)
                    context.beginPage(withBounds: imageBounds, pageInfo: [:])
                    image.draw(in: imageBounds)
                }
            }
            completion(pdfURL)
        } catch {
            print("Could not save PDF file: \(error)")
            completion(nil)
        }
    }
}
