//
//  TextDisplayView.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 05/02/24.
//

import SwiftUI
import SwiftData
import PhotosUI

struct TextDisplayView: View {

    @Query
    private var texts : [IdentifiableText]  //variable that stores the retrieved texts
    @Environment(\.modelContext) private var modelContext //layer between the persistent storage and the app
    
    let photos : [IdentifiableImage]    //array of selected photos, passed from TextView
    @State private var showAlert = false    //used to activate the alert, only used when the user clicks the add button
    @State var editing: Bool = false    //used to manage the editing mode, only when the user press the edit button
    @State private var newTextName: String = ""     // used to store the new text that the user wants to add
    @State private var selectedText : String? //used to store the selected text by the user from the list
    

    
    func addItem(item : String){    //add item to the DB
        let newText = IdentifiableText(content: newTextName)    //create new text; the name act also as ID, useful to avoid duplicates
        modelContext.insert(newText)    //insert it in the DB
    }
    
    func deleteItem(_ item : IdentifiableText) {    //remove item from DB
        modelContext.delete(item)
    }
        
    var body: some View {
        Text("Texts")
            .font(.title)
            .bold()
        Spacer()
        List(selection: $selectedText){
            ForEach(texts){ text in    //displays each text saved in the context
                NavigationLink(destination:ProcessView(text: text.content, photosIn: photos)){
                    Text(text.content)
                }
            }
            .onDelete{ indexes in   // action to remove text
                for index in indexes{
                    deleteItem(texts[index])
                }
            }
            
        }
        .toolbar{
            ToolbarItem {
                HStack{
                    EditButton()
                    Button(action: {
                        showAlert = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .alert("New text to search", isPresented: $showAlert) {
                        Button("Save") {
                            addItem(item: newTextName)  //add to database
                            newTextName = ""    //reset the textfield
                            
                        }
                        Button("Cancel", role: .cancel, action: {})
                        
                        TextField("New Text", text: $newTextName)
                        
                    } message: {
                        Text("Please enter the text")
                    }
                }
                
            }
        }
    }
}

