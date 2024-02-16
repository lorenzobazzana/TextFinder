//
//  TextRecognizer.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 07/02/24.
//
import Foundation
import Vision
import VisionKit
import CoreImage

class TextRecognizer: ObservableObject{ //Observable because it will notify all views observing the object that a state change has occurred and that they should update accordingly.
    
    var photos: [IdentifiableImage] //array containg the photos, we will receive it from the calling view
    var cgImageArray = [CGImage]()  //array used to store the convert the photos in the CGImage format, used by ML model.
    @Published var numberImagesProcessed: Int = 0 //Published is a wrapper that automatically publishes changes to a property to all registered observers, in our case will be useful in the progress bar view.
    
    init(photos:[IdentifiableImage]) {  //in the builder we convert automatically each IdentifiableImage into CGImage.
        self.photos = photos
        convertPhotos(photos: photos)
    }
    
    func convertPhotos(photos: [IdentifiableImage]){ //used to convert IdentifianbleImage (i.e. NSData) to CGImage
        
        for data in photos {
            if let imageData = data.data as Data? { //access to IdentifiableImage data attribute
                if let image = UIImage(data: imageData) {
                    cgImageArray.append(image.cgImage!) //append to the array of CGImages
                    }
                } else {
                    print("Error while reading the image.")
                }
            }
        }
    
    //dispatch queue to delegate the process of recognizing the text to a secondary process
    private let queue = DispatchQueue(label: "texts",qos: .default,attributes: [],autoreleaseFrequency: .workItem)
    
    //function to recognize the text, in our case the input given is an handler which contains tuples (int,string) will be modified to return the obtained results
    func recognizeText(withCompletionHandler completionHandler: @escaping ([(Int,String)]) -> Void) {
        queue.async {   //execute in asynchronous way
            
            // we will create an array which will contain tuples (index,image,request). 
            // enumerated will return the index of each image
            let imagesAndRequests = self.cgImageArray.enumerated().map({(index:$0,image: $1, request:VNRecognizeTextRequest())})
            
            //text per photo will contain tuples, (index,observations) where index is the index in cgImageArray and observations contains the string of the recognized texts
            let textPerPhoto = imagesAndRequests.map({index,image,request in
                DispatchQueue.main.async {  //in asynch way the counter will be incremented
                    self.numberImagesProcessed += 1
                }
                //for each image a handler will be created
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do{
                    try handler.perform([request])  //the handler will perform the text recognition process
                    if let observations = request.results{  //if anything in the photo is found, it will concatenate the results in the observations string
                        // return (index,obs)
                        return (index,observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n"))
                    }
                }
                catch{
                    print(error)
                    return (-1,"Error")
                }
                return (-2,"")
            })
            DispatchQueue.main.async {
                completionHandler(textPerPhoto) //finally, once done, the main queue will return the results using the closure
            }
        }
    }
}
