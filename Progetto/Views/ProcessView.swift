//
//  ProcessView.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 06/02/24.
//

import SwiftUI
import Photos
import PhotosUI
import Vision
import UIKit

struct ProcessView: View {
    
    let selectedText : String  //this one will be passed from the textView
    let photos: [IdentifiableImage]
    @ObservedObject var processor: TextRecognizer
    @State var validPositions : [Int] = []
    @State var isProcessing: Bool = true
    @State var itemToShow: IdentifiableImage? = nil
    
    let grid: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    init(text: String, photosIn: [IdentifiableImage]){
        self.photos = photosIn
        self.selectedText = text
        self.processor = TextRecognizer(photos: photos)
    }
        
    var body: some View {
        
        VStack{
            if(isProcessing){
                VStack{
                    Text("Processed: \(processor.numberImagesProcessed)/\(photos.count)")
                    ProgressBarView(current: $processor.numberImagesProcessed, total:Double(photos.count))
                }
            }
            else{
                VStack{
                    Text("Found text in \(validPositions.count) images")
                    ScrollView {
                        LazyVGrid(columns: grid){
                            ForEach(validPositions, id: \.self) { idx in
                                GeometryReader{geometry in
                                    if let img = UIImage(data: photos[idx].data as Data){
                                        Image(uiImage: img)
                                            .resizable()
                                            .frame(width: geometry.size.width, height: geometry.size.width)
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                            .shadow(color: Color.black.opacity(0.2),radius:5, x:0,y:5)
                                            .onTapGesture {
                                                itemToShow = photos[idx]
                                            }.fullScreenCover(item: $itemToShow){ image in
                                                FullImageView(img: image, show:$itemToShow)
                                            }
                                    }else{
                                        Text("Error while creating UIImage")
                                    }
                                }.aspectRatio(1, contentMode: .fill)
                            }
                        }.padding()
                    }
                }
            }
        }.task{
            processor.recognizeText(withCompletionHandler: {res in
                if res.count > 0{
                    for el in res{
                        let index = el.0
                        let text = el.1
                        
                        if text.contains(selectedText){
                            self.validPositions.append(index)
                        }
                    }
                }
                
                if(processor.numberImagesProcessed == photos.count){
                    isProcessing = false
                    processor.numberImagesProcessed = 0
                }
            })
        }
        
    }
}

