//
//  PhotosView.swift
//  Progetto
//
//  Created by Lorenzo on 30/01/24.
//

import SwiftUI
// Generics is needed as a hack to pass Views without complaints from the compilers
struct WorkingView<Content: View, Next: View>: View {
    
    let title: String
    let icon: String 
    let displayView: Content
    let nextView: Next
    @Binding var canContinue: Bool
    
    init(title: String, icon: String, displayView: Content, nextView: Next, canContinue: Binding<Bool>){
        self.title = title
        self.icon = icon
        self.displayView = displayView
        self.nextView = nextView
        _canContinue = canContinue
    }
    
    var body: some View {
            VStack{
                displayView // devo passare un binding
                //Text("Hello, SwiftUI!")// qua ci va la griglia di foto
                // Idealmente facciamo una cosa tipo
                // Selected photos                    Edit
                // Edit ci permette di selezionarle, aggiungerne o rimuoverle
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar{
                        ToolbarItem(placement: .principal) {
                            HStack {
                                //Image(systemName: "photo.on.rectangle")
                                //Text("Select photos").font(.headline)
                                Label("\(title)", systemImage: "\(icon)").labelStyle(.titleAndIcon).font(.headline)
                            }
                        }
                    }
                Spacer()
                NavigationLink(destination: nextView){
                    Text("Continue")
                        .font(.system(size: 20))
                        .frame(width: 150)
                }
                .buttonStyle(.bordered)
                .disabled(!canContinue)
            }.padding()
    }
}


struct WorkingView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            WorkingView(title: "Title", icon: "checkmark.seal.fill", displayView: DummyView(), nextView: DummyView(), canContinue: .constant(false))
        }
    }
}
