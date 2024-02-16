//
//  PhotosDisplayView.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import SwiftUI
import Photos
import PhotosUI

struct PhotosDisplayView: View {
    
    @State var pickedPhotos : [PhotosPickerItem] = []
    var oldPickedPhotos: [PhotosPickerItem] = []
    @State var editing: Bool = false
    var pickerConfig = PHPickerConfiguration()
    @Binding var IDPhotos: [IdentifiableImage]
    //@State var showPhoto = false
    //@State var Gshow = false
    let grid: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var itemToShow: IdentifiableImage? = nil

    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack(alignment: .firstTextBaseline){
                Text("Selected photos")
                    .font(.title)
                .bold()
                Spacer()
                if(editing){
                    Button(action: {}){
                        Text("Select all")
                    }.padding(.trailing)
                }
                else{
                    Button("Edit"){
                        //Text("Edit")
                        editing = true
                    }
                    .padding(.trailing)
                }
                
            }
            //.border(.red)
            //.padding(5)
            GeometryReader{geometry in
                ScrollView {
                    LazyVGrid(columns: grid, spacing: 2){
                        ForEach(IDPhotos){photo in
                            let img = UIImage(data:photo.data as Data)
                            ThumbnailImage(img: img!, thumbnailSize: 50, editing: $editing, width: 0.25*geometry.size.width, heigth: 0.25*geometry.size.width)
                                .onTapGesture {
                                    if (!editing){
                                        //showPhoto = true
                                        itemToShow = photo
                                    }
                                //    FullImageView(image: img, width: geometry.size.width, height: geometry.size.height)
                                 }.fullScreenCover(item: $itemToShow){ image in
                                        FullImageView(img: image, show:$itemToShow)
                                }
                            //fullScreenCover(isPresented: $showPhoto, content: {
                            //FullImageView(img: img, show: $showPhoto)
                            //
                        //})
                            //(img:img!, thumbnailSize: 50, width:0.25*geometry.size.width, heigth:0.25*geometry.size.width,editing:$editing,showPhoto:$showPhoto)
                            //IdentifiableImage.thumbnailImage(img!, thumbnailSize: 50)
                            
                                
                            //Text("\(photo.id)")
                        
                    }
                    }}
                //.padding()
            }
            Text("Number of photos: \(IDPhotos.count)")
            Spacer()
            
            if(editing){
                HStack{
                    PhotosPicker(selection: $pickedPhotos,
                                 matching: .images) {
                        Text("Add")
                    }
                    Spacer()
                    Button(action:{}){
                        Text("Remove")
                    }
                    .foregroundColor(.red)
                    Spacer()
                    Button("Cancel"){
                        editing = false
                    }
                }
                .padding(.horizontal)
            }
            Text("Selected \(IDPhotos.count) photo" + (IDPhotos.count == 1 ? "" : "s"))
                .padding(.top)
            
        }.task(id: pickedPhotos){
            //IDPhotos = []
            for photo in pickedPhotos{
                if let extractedImage = try? await photo.loadTransferable(type: Data.self){
                    let imageToAppend = IdentifiableImage(rawData: extractedImage as NSData)
                    if !(IDPhotos.contains(imageToAppend)){
                        IDPhotos.append(imageToAppend)
                    }
                }
            }
            editing = false
            //let diff = pickedPhotos.difference(from: oldPickedPhotos)
            //provare a metterlo in una coda asincrona
            /*for photo in pickedPhotos{
                if let extractedImage = try? await photo.loadTransferable(type: Data.self){
                    let imageToAppend = IdentifiableImage(rawData: extractedImage as NSData)
                    //if !IDPhotos.contains(imageToAppend){
                        IDPhotos.append(imageToAppend)
                    //}
                }*/
        }
    }
}

struct PhotosDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        PhotosDisplayView(IDPhotos: .constant([]))
        //PhotosView()
    }
}
