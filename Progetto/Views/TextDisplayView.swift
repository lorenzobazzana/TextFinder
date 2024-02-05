//
//  TextDisplayView.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 05/02/24.
//

import SwiftUI
import SwiftData


struct TextDisplayView: View {

    @Query
    private var texts : [IdentifiableText]
    @Environment(\.modelContext) private var modelContext //layer between the persistent storage and the app
    
    @State private var showAlert = false
    @State var editing: Bool = false
    @State private var newTextName: String = ""

    
    func addItem(item : String){
        let newText = IdentifiableText(content: newTextName)
        modelContext.insert(newText)
    }
    
    func deleteItem(_ item : IdentifiableText) {
        modelContext.delete(item)
    }
    
    var body: some View {
        Text("Texts")
            .font(.title)
            .bold()
        Spacer()
        List{
            ForEach(texts) { text in
                Text(text.content)
            }
            .onDelete{ indexes in
                for index in indexes{
                    deleteItem(texts[index])
                }
            }
            
        }.toolbar{
            ToolbarItem {
                HStack{
                    Button(action: {
                        showAlert = true
                    }) {
                        Label("Add Item", systemImage: "plus")
                    }
                    .alert("Text Data", isPresented: $showAlert) {
                        Button("Save") {
                            addItem(item: newTextName)  //add to database
                            
                        }
                        Button("Cancel", role: .cancel, action: {})
                        
                        TextField("Content", text: $newTextName)
                        
                    } message: {
                        Text("Please enter data for new text")
                    }
                }
                
            }
        }
        
    }
}

struct TextDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TextDisplayView()
        }
    }
}
