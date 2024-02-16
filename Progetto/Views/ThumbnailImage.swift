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
    let editing: Bool
    let isSelected: Bool
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
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        /*.offset(y:self.Gshow ? 0:UIScreen.main.bounds.height)
            .animation(Animation.spring().delay(Double(idx)*0.1),value:Gshow)*/
            .shadow(color: Color.black.opacity(0.2),radius:5, x:0,y:5)
            .padding([.bottom],7)
            .overlay(alignment: .topTrailing) {
                if editing {
                    let symbol = isSelected ? "checkmark.circle.fill" : ""
                    Image(systemName: symbol)
                        .font(Font.title)
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .blue)
                        .background(.white)
                        //.foregroundStyle(.white)
                        .clipShape(Circle())
                        .offset(x: 7, y: -7)
                }
            }
    }
}

/*#Preview {
    ThumbnailImage(img: UIImage(), thumbnailSize: 300)
}*/
