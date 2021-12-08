//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/5/21.
//

import SwiftUI
import AppKit
import Foundation

struct macComboBox: View {
    @Binding var items: [String]
    @Binding var selectedItem: String
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox(content: .constant(["Hello", "World", "7"]), selectedItem: .constant("Hello"))
    }
}
