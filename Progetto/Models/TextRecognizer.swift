//
//  TextRecognizer.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 07/02/24.
//
import Foundation
import Vision
import VisionKit

final class TextRecognizer{
    
    var photos: [IdentifiableImage]
    var cgImageArray = [CGImage]()
    
    init(photos:[IdentifiableImage]) {
        self.photos = photos
        convertPhotos(photos: photos)
    }
    
    func convertPhotos(photos: [IdentifiableImage]){        //convert NSData to CGImage
        for data in photos {
            if let imageData = data.data as Data? {
                if let image = UIImage(data: imageData) {
                    if let cgImage = image.cgImage {
                        cgImageArray.append(cgImage)
                    } else {
                        print("Impossibile ottenere CGImage dall'UIImage.")
                    }
                } else {
                    print("Impossibile creare UIImage dall'NSData.")
                }
            } else {
                print("NSData non valido.")
            }
        }
    }
    
    private let queue = DispatchQueue(label: "texts",qos: .default,attributes: [],autoreleaseFrequency: .workItem)
    
    func recognizeText(withCompletionHandler completionHandler: @escaping ([(Int,String)]) -> Void) {
        queue.async {
            let imagesAndRequests = self.cgImageArray.enumerated().map({(index:$0,image: $1, request:VNRecognizeTextRequest())})
            let textPerPage = imagesAndRequests.map{index,image,request in
                let handler = VNImageRequestHandler(cgImage: image, options: [:])
                do{
                    try handler.perform([request])
                    if let observations = request.results{
                        return (index,observations.compactMap({$0.topCandidates(1).first?.string}).joined(separator: "\n"))
                    }
                }
                catch{
                    print(error)
                    return (-1,"Error")
                }
                return (-2,"")
            }
            DispatchQueue.main.async {
                completionHandler(textPerPage)
            }
        }
    }
}
