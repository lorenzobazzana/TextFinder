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
    @State var context = CIContext()
    
    init(text: String, photosIn: [IdentifiableImage]){
        self.photos = photosIn
        self.selectedText = text
        self.processor = TextRecognizer(photos: photos)
    }
        
    var body: some View {
        
        VStack{
            //Image(uiImage: filtered)
            ForEach(validPositions, id: \.self) { idx in
                    //Text("\(idx)")
                //Text("Len: \(validPositions.count)")
                    //let imgIndx = validPositions[idx]
                if let img = UIImage(data: photos[idx].data as Data){
                    if let filteredImage = applyFilter(img: img){
                        Image(uiImage: UIImage(cgImage: filteredImage))
                            .resizable()
                            .frame(width: 100, height: 100)
                            .aspectRatio(contentMode: .fit)
                    } else{
                        Text("Error while applying filter")
                    }
                } else{
                    Text("Error while creating UIImage")
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
            })
        }
        
    }
}

extension ProcessView{
    func applyFilter(img: UIImage) -> CGImage?{
        if let mtlDev = MTLCreateSystemDefaultDevice(){
            context = CIContext(mtlDevice: mtlDev)
        } else{
            context = CIContext(options: nil)
        }
        
        
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(CIImage(image:img), forKey: "inputImage")
        filter?.setValue(1.0, forKey: "inputIntensity")
        filter?.setValue(CIColor.gray, forKey: "inputColor")

        if let outPutImage = filter?.outputImage, let cg = context.createCGImage(outPutImage, from: outPutImage.extent){
            return cg
        } else {
            return nil
        }
    }
}
