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
final class TextRecognizer: ObservableObject{
    
    let filter = CIFilter(name: "CIColorMonochrome")
    var photos: [IdentifiableImage]
    var cgImageArray = [CGImage]()
    var context = CIContext()
    @Published var numberImagesProcessed: Int = 0
    
    init(photos:[IdentifiableImage]) {
        self.photos = photos
        convertPhotos(photos: photos)
        filter?.setValue(1.0, forKey: "inputIntensity")
        filter?.setValue(CIColor.gray, forKey: "inputColor")
    }
    
    func convertPhotos(photos: [IdentifiableImage]){        //convert NSData to CGImage
        if let mtlDev = MTLCreateSystemDefaultDevice(){
            context = CIContext(mtlDevice: mtlDev)
        }else{
            context=CIContext(options: nil)
        }
        
        for data in photos {
            if let imageData = data.data as Data? {
                if let image = UIImage(data: imageData) {
                        //let inputImage = CIImage(image: image) //apply filter
                        //filter?.setValue(inputImage, forKey: "inputImage")
                        //if let outputImage = filter?.outputImage,
                        //   let cg=context.createCGImage(outputImage, from: outputImage.extent){
                        //    cgImageArray.append(cg)
                    cgImageArray.append(image.cgImage!)
                       /* }
                    } else {
                        print("Impossibile creare UIImage dall'NSData.")
                    */}
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
                DispatchQueue.main.async {
                    self.numberImagesProcessed += 1
                }
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
