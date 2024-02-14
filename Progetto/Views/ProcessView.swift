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
    let processor: TextRecognizer
    @State var validPositions : [Int] = []
    
    init(text: String, photosIn: [IdentifiableImage]){
        self.photos = photosIn
        self.selectedText = text
        self.processor = TextRecognizer(photos: photos)
    }
        
    var body: some View {
        
        VStack{
            //Image(uiImage: filtered)
            ForEach(validPositions, id: \.self) { idx in
                    let img = UIImage(data: photos[idx].data as Data)
                       Image(uiImage: img!)
                       .resizable()
                       .frame(width: 100, height: 100)
                       .aspectRatio(contentMode: .fit)
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
                    }}
            })
        }
        
    }
}

