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
    //@Binding var pickedPhotos : [PhotosPickerItem] //This one will be used to receive the selected photos
    let photos: [IdentifiableImage]// = []
    @ObservedObject var processor: TextRecognizer
    @State var validPositions : [Int] = []
    @State var isProcessing: Bool = true
    @State var itemToShow: IdentifiableImage? = nil
    //@State var context = CIContext()
    
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
                //DispatchQueue.main.async {
                VStack{
                    Text("Processed: \(processor.numberImagesProcessed)/\(photos.count)")
                    ProgressBarView(current: $processor.numberImagesProcessed, total:Double(photos.count))
                }
                    //state.incProgress(val: Double(1)/Double(photos.count))
                    //if processor.numberImagesProcessed == photos.count {
                    //    isProcessing = false
                    //}
                //}
            }
            else{
                Text("Found text in \(validPositions.count) images")
                //Image(uiImage: filtered)
                    ScrollView {
                        GeometryReader{geometry in
                        LazyVGrid(columns: grid, spacing: 2){
                            ForEach(validPositions, id: \.self) { idx in
                                //Text("\(idx)")
                                //Text("Len: \(validPositions.count)")
                                //let imgIndx = validPositions[idx]
                                if let img = UIImage(data: photos[idx].data as Data){
                                    //if let filteredImage = applyFilter(img: img){
                                    Image(uiImage: img) //UIImage(cgImage: filteredImage))
                                        .resizable()
                                        .frame(width: 0.23*geometry.size.width, height: 0.23*geometry.size.width)
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                        .shadow(color: Color.black.opacity(0.2),radius:5, x:0,y:5)
                                        .padding([.all],7)
                                        .onTapGesture {
                                                itemToShow = photos[idx]
                                        //    FullImageView(image: img, width: geometry.size.width, height: geometry.size.height)
                                         }.fullScreenCover(item: $itemToShow){ image in
                                                FullImageView(img: image, show:$itemToShow)
                                        }
                                    //} else{
                                    //Text("Error while applying filter")
                                    //}
                                } else{
                                    Text("Error while creating UIImage")
                                }
                            }
                        }
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
                }
            })
        }
        
    }
}

