//
//  ThumbnailImage.swift
//  Progetto
//
//  Created by Lorenzo on 15/02/24.
//

import SwiftUI

struct ThumbnailImage: View {
    @State var img: UIImage
    let thumbnailSize: Int
    @Binding var editing: Bool
    //@Binding var showPhoto: Bool
    let width : Double
    let heigth : Double
    
    var body: some View {
        let finalSize = CGSize(width: thumbnailSize, height: thumbnailSize)
        let renderer = UIGraphicsImageRenderer(size: finalSize)
        let thumbnailImage = renderer.image { context in
            img.draw(in: CGRect(origin: .zero, size: finalSize))
        }
        Image(uiImage: thumbnailImage)
            .resizable()
            .scaledToFill()
            .frame(width: width, height: heigth, alignment: .center)
            .clipped()
        /*.offset(y:self.Gshow ? 0:UIScreen.main.bounds.height)
            .animation(Animation.spring().delay(Double(idx)*0.1),value:Gshow)*/
            .shadow(color: Color.black.opacity(0.2),radius:10, x:0,y:10)
    }
}

/*#Preview {
    ThumbnailImage(img: UIImage(), thumbnailSize: 300)
}*/
