//
//  IdentifiableText.swift
//  Progetto
//
//  Created by Lorenzo Zanolin on 05/02/24.
//

import Foundation
import SwiftData

@Model
class IdentifiableText : Identifiable{
    let id: String
    let content : String    // the content of the text that is searched in the images
    init(content: String) {
        self.content = content
        self.id = UUID().uuidString
    }
}


