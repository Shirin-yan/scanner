//
//  CropperView.swift
//  Scanner
//
//  Created by Shirin-Yan on 26.08.2024.
//

import SwiftUI
import TOCropViewController

struct CropperView: UIViewControllerRepresentable {
    
    @Environment(\.presentationMode) var presentationMode

    var image: UIImage
    var didCrop: (UIImage)->()
    
    class Coordinator: NSObject, TOCropViewControllerDelegate {
        var parent: CropperView
        
        init(parent: CropperView) {
            self.parent = parent
        }
        
        func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
            parent.didCrop(image)
            parent.presentationMode.wrappedValue.dismiss()
        }

        func cropViewController(_ cropViewController: TOCropViewController, didFinishCancelled cancelled: Bool) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> TOCropViewController {
        let cropViewController = TOCropViewController(image: image)
        cropViewController.delegate = context.coordinator
        return cropViewController
    }
    
    func updateUIViewController(_ uiViewController: TOCropViewController, context: Context) { }
}
