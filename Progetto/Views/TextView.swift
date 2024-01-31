//
//  TextView.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import SwiftUI

struct TextView: View {
    
    @State var canContinue: Bool = false
    
    var body: some View {
        WorkingView(title: "Select text", icon: "text.justifyleft", displayView: DummyView(), nextView: DummyView(), canContinue: $canContinue)
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            TextView()
        }
    }
}
