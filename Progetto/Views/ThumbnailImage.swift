//
//  ThumbnailImage.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 15/02/24.
//

import SwiftUI

struct ThumbnailImage: View {   //used to visualize correctly each thumbnail of the images
    
    // various constants
    let img: UIImage
    let thumbnailSize: Int
    let width : Double
    let heigth : Double
    //useful to manage actions
    let editing: Bool   //used to check wheter the user has pressed the button edit
    let isSelected: Bool //used to check wheter the user has selected the image
    let symbol = "checkmark.circle.fill"
    
    var body: some View {
        let finalSize = CGSize(width: thumbnailSize, height: thumbnailSize)
        let renderer = UIGraphicsImageRenderer(size: finalSize) //used to create the thumbnail image
        let thumbnailImage = renderer.image { context in    //from the UIImage convert it into a thumb img
            img.draw(in: CGRect(origin: .zero, size: finalSize))
        }
        Image(uiImage: thumbnailImage)  //print it on screen
            .resizable()
            .scaledToFill()
            .frame(width: width, height: heigth, alignment: .center)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))  //round corners
            .shadow(color: Color.black.opacity(0.2),radius:5, x:0,y:5)
            .padding([.bottom],7)
            .overlay(alignment: .topTrailing) {
                if editing {    //if the user has pressed the edit button, then show the circle on topright
                    if isSelected{
                        Image(systemName: symbol)
                            .font(Font.title)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.white, .blue)
                            .background(.white)
                            .clipShape(Circle())
                            .offset(x: 7, y: -7)
                    }
                    
                }
            }
    }
}
