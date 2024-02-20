//
//  PhotosDisplayView.swift
//  TextFinder
//
//  Created by Lorenzo Bazzana on 31/01/24.
//

import SwiftUI
import Photos
import PhotosUI

struct PhotosDisplayView: View {
    
    @State var pickedPhotos : [PhotosPickerItem] = []    // The result of the PhotoPicker selection
    @State var oldPickedPhotos: [PhotosPickerItem] = []  // Used for checking what changes have been made to the selection
    @State var editing: Bool = false                     // Used to show the edit menu
    var pickerConfig = PHPickerConfiguration()
    @Binding var IDPhotos: [IdentifiableImage]           // Selected pictures
    @State var selectedPhotos = Dictionary<UUID, Bool>() // Dictionary used to check efficiently whether the user has selected a photo for removal
    @State var isRemoving: Bool = false                  // Used to avoid eliminating more images than intended
    
    let grid: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var itemToShow: IdentifiableImage? = nil     // Item to display in fullScreenCover
    
    // Selects all photos for removal
    func selectAll(){
        for photo in IDPhotos{
            selectedPhotos[photo.id] = true
        }
    }
    
    // Remove the selected photos
    func removeSelected(){
        isRemoving = true
        var indicesToRemove: [Int] = []
        for idx in IDPhotos.indices {
            if selectedPhotos[IDPhotos[idx].id] != nil{
                indicesToRemove.append(idx)
            }
        }
        IDPhotos.remove(atOffsets: IndexSet(indicesToRemove))
        pickedPhotos.remove(atOffsets: IndexSet(indicesToRemove))
        
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
                        editing = true
                    }
                    .padding(.trailing)
                }
                
            }
            .padding()
                // View containing all the photos picked by the user, organized in 4 columns
                ScrollView {
                    LazyVGrid(columns: grid){
                        ForEach(IDPhotos){photo in // We display each photo in the grid, as a ThumbnailImage to improve loading and scrolling performance
                            GeometryReader{geometry in
                                let img = UIImage(data:photo.data as Data)
                                // We only show a Thumbnail with reduced size for efficiency reasons
                                ThumbnailImage(img: img!, thumbnailSize: 50, width: geometry.size.width, heigth: geometry.size.width, editing: editing, isSelected: selectedPhotos[photo.id] ?? false)
                                    .onTapGesture {
                                        // If we are not in editing mode, show the image in full screen
                                        if (!editing){
                                            itemToShow = photo
                                        } else{
                                            // If we are in editing mode, either add or remove the photo from the selected pictures to be removed
                                            if selectedPhotos[photo.id] == nil{
                                                selectedPhotos[photo.id] = true
                                            } else{
                                                selectedPhotos.removeValue(forKey: photo.id)
                                            }
                                        }
                                    }
                                    .fullScreenCover(item: $itemToShow){ image in
                                        FullImageView(img: image, show:$itemToShow)
                                    }
                            }
                            .aspectRatio(1, contentMode: .fill)
                        }
                    }
                    .padding()
                }
            Spacer()
            
            if(editing){ // Editing buttons
                HStack{
                    PhotosPicker(selection: $pickedPhotos,
                                 matching: .images) {
                        Text("Add")
                    }
                    Spacer()
                    Button(action:{withAnimation(){removeSelected()}}){
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
            
        }.task(id: pickedPhotos){ // When the user selects different photos with the PhotosPicker, we must update the photo array accordingly, adding the new images and removing the discarded ones
            if !isRemoving{
                editing = false
            }
            let diff = pickedPhotos.difference(from: oldPickedPhotos) // We compute the difference between the old picked selection and the new one
            
            for photo in diff{
                switch photo{
                    case .remove(let offset, _, _): // In the case of a removal, we remove the corresponding item, but only if the change to PhotosPicker is not due to a removal with the "Remove" button (this avoids double removals)
                        if !isRemoving{
                            IDPhotos.remove(at: offset)
                        }
                    case .insert(let offset, let addedPhoto, _): // In the case of an insertion we load the image and add it
                        if let extractedImage = try? await addedPhoto.loadTransferable(type: Data.self){
                            let imageToAppend = IdentifiableImage(rawData: extractedImage as NSData)
                            if (!IDPhotos.contains(imageToAppend)){ // This is useful to avoid adding copies of the image, which could happen if the user goes back to the home screen of the app
                                IDPhotos.insert(imageToAppend, at: offset)
                            }
                        }
                }
            }
            oldPickedPhotos = pickedPhotos
            if isRemoving{
                isRemoving = false
            }
        }
    }
}
