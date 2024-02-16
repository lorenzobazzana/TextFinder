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
    @State var selectedPhotos = Dictionary<UUID, Bool>()
    //@State var showPhoto = false
    //@State var Gshow = false
    let grid: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var itemToShow: IdentifiableImage? = nil
    
    func selectAll(){
        for photo in IDPhotos{
            selectedPhotos[photo.id] = true
        }
    }
    
    func removeSelected(){
        var indicesToRemove: [Int] = []
        for idx in IDPhotos.indices {
            if selectedPhotos[IDPhotos[idx].id] != nil{
                indicesToRemove.append(idx)
            }
        }
        IDPhotos.remove(atOffsets: IndexSet(indicesToRemove))
    }

    
    var body: some View {
        
        VStack(alignment: .leading){
            HStack(alignment: .firstTextBaseline){
                Text("Selected photos")
                    .font(.title)
                .bold()
                Spacer()
                if(editing){
                    Button("Cancel"){
                        editing = false
                        selectedPhotos.removeAll()
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
            .padding()
            //.border(.red)
            //.padding(5)
                ScrollView {
                    LazyVGrid(columns: grid){//, spacing: 2){
                        ForEach(IDPhotos){photo in
                            GeometryReader{geometry in
                                let img = UIImage(data:photo.data as Data)
                                ThumbnailImage(img: img!, thumbnailSize: 50, editing: editing, isSelected: selectedPhotos[photo.id] ?? false, width: geometry.size.width, heigth: geometry.size.width)
                                    .onTapGesture {
                                        if (!editing){
                                                //showPhoto = true
                                            itemToShow = photo
                                        } else{
                                            if selectedPhotos[photo.id] == nil{
                                                selectedPhotos[photo.id] = true
                                            } else{
                                                selectedPhotos.removeValue(forKey: photo.id)
                                            }
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
                            .aspectRatio(1, contentMode: .fill)
                        }
                    }
                    .padding()
                //.padding()
                }
            //Text("Number of photos: \(IDPhotos.count)")
            Spacer()
            
            if(editing){
                HStack{
                    PhotosPicker(selection: $pickedPhotos,
                                 matching: .images) {
                        Text("Add")
                    }
                    Spacer()
                    Button(action:{removeSelected()}){
                        Text("Remove")
                    }
                    .foregroundColor(.red)
                    Spacer()
                    Button(action: {selectAll()}){
                        Text("Select all")
                    }
                }
                .padding(.horizontal)
            }
            Text("Selected \(IDPhotos.count) photo" + (IDPhotos.count == 1 ? "" : "s"))
                .padding()
            
        }.task(id: pickedPhotos){
            //IDPhotos = []
            editing = false
            for photo in pickedPhotos{
                if let extractedImage = try? await photo.loadTransferable(type: Data.self){
                    let imageToAppend = IdentifiableImage(rawData: extractedImage as NSData)
                    if !(IDPhotos.contains(imageToAppend)){
                        IDPhotos.append(imageToAppend)
                    }
                }
            }
            
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
