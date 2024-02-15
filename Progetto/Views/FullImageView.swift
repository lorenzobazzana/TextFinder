//
//  FullImageView.swift
//  Progetto
//
//  Created by Lorenzo on 14/02/24.
//

import SwiftUI

struct FullImageView: View {
    @Binding var show:Bool
    @State var viewState : CGSize = .zero
    let img: UIImage
    //let id:String
    
    
    init(img: UIImage, show : Binding<Bool>) {
        //self.img = UIImage(data: img.data as Data) ?? UIImage()
        self.img=img
        self._show = show
        //self.id = id
    }
    
    var body: some View {
        VStack{
            //Text("\(id)")
            Image(uiImage: self.img)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Apply filter")
            })
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
                    show = false    //close the view
                }
                withAnimation{viewState = .zero}})
        )
            
    }
}

#Preview {
    FullImageView(img: UIImage(),show:.constant(false))
    //IdentifiableImage(rawData: NSData())
}
