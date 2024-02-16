//
//  IdentifiableImage.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import PhotosUI
import SwiftUI

class IdentifiableImage: Identifiable, Equatable{
    
    let id: UUID
    let data: NSData
    
    init(rawData: NSData){
        self.id = UUID()
        self.data = rawData
    }
    
    // Needed for comparisons
    static func == (lhs: IdentifiableImage, rhs: IdentifiableImage) -> Bool {
        return lhs.data.isEqual(rhs.data)
    }
    
}
extension IdentifiableImage {
    static func thumbnailImage(_ uiImage: UIImage, thumbnailSize: Int = 300) -> Image {
        
        let finalSize = CGSize(width: thumbnailSize, height: thumbnailSize)
        let renderer = UIGraphicsImageRenderer(size: finalSize)
        let thumbnailImage = renderer.image { context in
            uiImage.draw(in: CGRect(origin: .zero, size: finalSize))
        }
 
        return Image(uiImage: thumbnailImage)
    }
}

