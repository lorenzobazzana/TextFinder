//
//  FullImageView.swift
//  TextFinder
//
//  Created by Lorenzo Zanolin on 14/02/24.
//

import SwiftUI

struct FullImageView: View {
    @Binding var show:IdentifiableImage?    //the (selected) image passed from the ProcessView, in this case it will be reset to close the fullscreen view
    @State var viewState : CGSize = .zero
    @State var img: UIImage     //variable used to convert the image in UIImage
    @State var appliedFilter: Bool  //variable used to check whether the filter is applied
    
    
    init(img: IdentifiableImage, show : Binding<IdentifiableImage?>) {
        self.img = UIImage(data: img.data as Data) ?? UIImage()
        self._show = show
        self.appliedFilter = false
    }
    
    func applyFilter(){     //function used to apply the filter
        let context: CIContext //context used to render the image and apply the filter
        if let mtlDev = MTLCreateSystemDefaultDevice(){
            context = CIContext(mtlDevice: mtlDev)
        } else{
            context = CIContext(options: nil)
        }
        
        //filter definition
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(CIImage(image:self.img), forKey: "inputImage")
        filter?.setValue(1.0, forKey: "inputIntensity")
        filter?.setValue(CIColor.gray, forKey: "inputColor")

        //apply the filter, if the filter output is valid AND if is possible to create a CGImage from the filter output then save the image
        if let outPutImage = filter?.outputImage, let cg = context.createCGImage(outPutImage, from: outPutImage.extent){
            self.img = UIImage(cgImage: cg)
        }
        
        appliedFilter = true    //set the boolean to true, used to avoid applying two times the filter to the photo
    }
    
    func removeFilter(){    //remove the filter
        self.img = UIImage(data: show!.data as Data) ?? UIImage()
        appliedFilter = false
    }
    
    var body: some View {
        VStack{
            Image(uiImage: self.img)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            if !appliedFilter{  //if the filter has not been already applied, then apply it
                Button(action: {applyFilter()}, label: {
                    Text("Apply filter")
                })
            }else{
                Button(action: {removeFilter()}, label: {
                    Text("Remove filter")
                })
            }
            
            
        }.gesture(  //used to close the fullImage view when the user scrolls downward on top 
            DragGesture()   //object that detects the drag gesture from the user
                .onChanged{ //executed when the gesture is detected
                    value in
                    if value.startLocation.y > UIScreen.main.bounds.height + 100{
                        viewState = value.translation   // viewState saved the vertical transition
                    }
                }
                .onEnded({value in  //executed when the scroll gesture is ended
                if viewState.height < 50{   //checks whether the vertical scrolling has length < 50 pt
                    show = nil    //close the view
                }
                withAnimation{viewState = .zero}})  //fluid closing animation
        )
            
    }
}

