//
//  DocScannerView.swift
//  Scanner
//
//  Created by Shirin-Yan on 23.08.2024.
//

import SwiftUI
import VisionKit

struct DocumentScannerView: UIViewControllerRepresentable {

    @Binding var isPresented: Bool
    public var onCompletion: ([UIImage]) -> Void
        
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let vc = VNDocumentCameraViewController()
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

extension DocumentScannerView {
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
        var parent: DocumentScannerView
        
        init(_ parent: DocumentScannerView) {
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            parent.onCompletion((0..<scan.pageCount).map(scan.imageOfPage(at:)))
            parent.isPresented = false
        }
        
        func documentCameraViewControllerDidCancel(_ controller: VNDocumentCameraViewController) {
            parent.isPresented = false
        }
        
        public func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFailWithError error: Error) {
            debugPrint(error)
            parent.onCompletion([])
            parent.isPresented = false
        }
    }
}
