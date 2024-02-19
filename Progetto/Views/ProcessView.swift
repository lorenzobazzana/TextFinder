//
//  ProcessView.swift
//  TextFinder
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
    let photos: [IdentifiableImage] //selected photos from the user
    @ObservedObject var processor: TextRecognizer   //text recognizer, in this case we used as observed to access the current number of processed images.
    @State var validPositions : [Int] = []  //array containing the positions (in the photos array) in which text is recognized
    @State var isProcessing: Bool = true    //boolean that is true when the ML model is processing
    @State var itemToShow: IdentifiableImage? = nil
    
    let grid: [GridItem] = [    //used to visualize the resulted images in a grid
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
            if(isProcessing){   //only when the model is processing
                VStack{
                    Text("Processed: \(processor.numberImagesProcessed)/\(photos.count)")   //we visualize the number of currently analyzed images
                    ProgressBarView(current: $processor.numberImagesProcessed, total:Double(photos.count))  //pass it to the progress bar view
                }
            }
            else{
                VStack{
                    Text("Found text in \(validPositions.count) images")
                    ScrollView {    //we visualize the images found
                        LazyVGrid(columns: grid){
                            ForEach(validPositions, id: \.self) { idx in // in this case validPosition need an id since Int is not Identifiable
                                GeometryReader{geometry in
                                    if let img = UIImage(data: photos[idx].data as Data){   //visualize the images
                                        Image(uiImage: img)
                                            .resizable()
                                            .frame(width: geometry.size.width, height: geometry.size.width)
                                            .aspectRatio(contentMode: .fit)
                                            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                            .shadow(color: Color.black.opacity(0.2),radius:5, x:0,y:5)
                                            .onTapGesture { //if the user clicks an image, the itemToShow became that image
                                                itemToShow = photos[idx]
                                            }
                                            .fullScreenCover(item: $itemToShow){ image in   //now if the itemToShow is not null, the fullScreenCover activates. itemToShow will be resetted inside FullImageView, to close the view
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
        }.task{     //asynchronous task of the view, used to activate the ML model and search the text within the images
            processor.recognizeText(withCompletionHandler: {res in      //this function will use the handler which contains tuples (int,String)
                if res.count > 0{
                    for el in res{  //res contains the tuples, el is a tuple
                        let index = el.0    //index is the first element of the tuple
                        let text = el.1     //text is the second element of the tuple
                        
                        if text.contains(selectedText){     //in the case that the recognized text in a image contains the selected text from the user
                            self.validPositions.append(index)   //we save the position of the image in our array
                        }
                    }
                }
                
                if(processor.numberImagesProcessed == photos.count){    //once we have analyzed all the images
                    isProcessing = false    //we turn off the progressBarView
                    processor.numberImagesProcessed = 0     //we reset the processor count, needed to avoid situations of overloading in the case we redo the processing
                }
            })
        }
        
    }
}

