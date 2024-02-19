//
//  HelpView.swift
//  TextFinder
//
//  Created by Lorenzo Bazzana on 19/02/24.
//

import SwiftUI

struct HelpView: View {
    
    @Binding var help: Bool // used to show and hide the help panel
    
    var body: some View {
        VStack{
            Spacer()
            Text("TextFinder")
                .font(.title)
                .bold()
            Text("This App lets you filter the photos you select by a certain text:")
            Text("\u{2022} In the \"Select photos\" screen you can select the photos you want to find the text in")
            Text("\u{2022} In the \"Select text\" screen you can save texts for future use, and select the one you want to find in the photos")
            Text("\u{2022} After selecting the photos and the text, only the photos containing said text will be shown.")
            Spacer()
            Button("Close"){
                help = false
            }
            Spacer()
        }
    }
}

#Preview {
    HelpView(help: .constant(false))
}
