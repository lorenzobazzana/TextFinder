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
    @Attribute(.unique) var content : String    // the content of the text that is searched in the images, in this case unique to avoid duplicates and act as id, var because it can be changed, if edited
    init(content: String) {
        self.content = content
    }
}


