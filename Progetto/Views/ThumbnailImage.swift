//
//  ThumbnailImage.swift
//  Progetto
//
//  Created by Lorenzo on 15/02/24.
//

import SwiftUI

struct ThumbnailImage: View {
    let img: UIImage
    let thumbnailSize: Int
    
    var body: some View {
        let finalSize = CGSize(width: thumbnailSize, height: thumbnailSize)
        let renderer = UIGraphicsImageRenderer(size: finalSize)
        let thumbnailImage = renderer.image { context in
            img.draw(in: CGRect(origin: .zero, size: finalSize))
        }
        Image(uiImage: thumbnailImage)
    }
}

#Preview {
    ThumbnailImage(img: UIImage(), thumbnailSize: 300)
}
