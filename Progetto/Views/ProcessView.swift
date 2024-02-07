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
    
    var selectedText : String  //this one will be passed from the textView
    //@Binding var pickedPhotos : [PhotosPickerItem] //This one will be used to receive the selected photos
    @Binding var photos: [IdentifiableImage]// = []
        
    func detectText(in image: UIImage) -> [VNRecognizedText]? {
            let request = VNRecognizeTextRequest()
            let handler = VNImageRequestHandler(cgImage: image.cgImage!, options: [:])
        
            do {
                try handler.perform([request])
            } catch {
                print("Errore durante l'elaborazione dell'immagine: \(error.localizedDescription)")
            }
        return request.results
    }
    
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
            Text()
        }
        
    }
}

