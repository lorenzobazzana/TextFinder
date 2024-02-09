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
    @State var ah: String = ""
    
    init(text: String, photosIn: [IdentifiableImage]){
        self.photos = photosIn
        self.selectedText = text
        self.processor = TextRecognizer(photos: photos)
    }
        
    /*func detectText(in image: UIImage) -> [VNRecognizedText]? {
            let request = VNRecognizeTextRequest()
            let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        
            do {
                try handler.perform([request])
            } catch {
                print("Errore durante l'elaborazione dell'immagine: \(error.localizedDescription)")
            }
        return request.results
    }*/
    
    var body: some View {
        //Text("\(selectedText)")
        //Spacer()
        //Text("\(pickedPhotos.count)")
        
        let data = photos[0].data
        let img = UIImage(data: data as Data)
        
        //let recognizer = TextRecognizer(photos: photos)
        //recognizer.recognizeText(withCompletionHandler: completionHandler)
        
        VStack{
            Image(uiImage: img!)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Text("\(ah)")
            Button("Start"){
            }
        }.task{
            processor.recognizeText(withCompletionHandler: {res in
                if res.count > 0{
                    ah = res[0]
                }
                else{
                    ah = "-1"
                }
            })
        }
        
    }
}

