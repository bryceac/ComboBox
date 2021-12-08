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
    
    var body: some View {
        Menu {
            ForEach(items, id: \.self) { choice in
                Button(choice) {
                    selectedItem = choice
                }
            }
        } label: {
            HStack {
                TextField("Selection", text: $selectedItem)
                Image(systemName: "chevron.down")
            }
        }
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox(content: .constant(["Hello", "World", "7"]), selectedItem: .constant("Hello"))
    }
}
