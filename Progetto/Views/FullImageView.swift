//
//  FullImageView.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 14/02/24.
//

import SwiftUI

struct FullImageView: View {
    @Binding var show:IdentifiableImage?
    @State var viewState : CGSize = .zero
    @State var img: UIImage
    @State var appliedFilter: Bool
    
    
    init(img: IdentifiableImage, show : Binding<IdentifiableImage?>) {
        self.img = UIImage(data: img.data as Data) ?? UIImage()
        self._show = show
        self.appliedFilter = false
    }
    
    func applyFilter(){
        let context: CIContext
        if let mtlDev = MTLCreateSystemDefaultDevice(){
            context = CIContext(mtlDevice: mtlDev)
        } else{
            context = CIContext(options: nil)
        }
        
        
        let filter = CIFilter(name: "CIColorMonochrome")
        filter?.setValue(CIImage(image:self.img), forKey: "inputImage")
        filter?.setValue(1.0, forKey: "inputIntensity")
        filter?.setValue(CIColor.gray, forKey: "inputColor")

        if let outPutImage = filter?.outputImage, let cg = context.createCGImage(outPutImage, from: outPutImage.extent){
            self.img = UIImage(cgImage: cg)
        }
        
        appliedFilter = true
    }
    
    func removeFilter(){
        self.img = UIImage(data: show!.data as Data) ?? UIImage()
        appliedFilter = false
    }
    
    var body: some View {
        VStack{
            Image(uiImage: self.img)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            if !appliedFilter{
                Button(action: {applyFilter()}, label: {
                    Text("Apply filter")
                })
            }else{
                Button(action: {removeFilter()}, label: {
                    Text("Remove filter")
                })
            }
            
            
        }.gesture(  //used to close the fullImage view when the user scrolls downward on top 
            DragGesture()
                .onChanged{
                    value in
                    if value.startLocation.y > UIScreen.main.bounds.height + 100{
                        viewState = value.translation
                    }
                }
                .onEnded({value in
                if viewState.height < 50{
                    show = nil    //close the view
                }
                withAnimation{viewState = .zero}})
        )
            
    }
}

