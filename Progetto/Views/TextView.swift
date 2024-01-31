//
//  TextView.swift
//  Progetto
//
//  Created by Lorenzo on 31/01/24.
//

import SwiftUI

struct TextView: View {
    var body: some View {
        WorkingView(title: "Select text", icon: "text.justifyleft", displayView: DummyView(), nextView: DummyView())
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}
