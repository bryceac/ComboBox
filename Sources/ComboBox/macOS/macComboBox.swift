//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/5/21.
//

import SwiftUI
import Foundation

struct macComboBox: View {
    @Binding var items: [String]
    @Binding var selectedItem: String
    @State var showOptions: Bool = false
    
    var body: some View {
        HStack {
            TextField("", text: $selectedItem)
            Spacer()
            Button(action: {
                showOptions = true
            }) {
                Image(systemName: "chevron.down")
            }.accessibilityLabel("expand")
                
        }.sheet(isPresented: $showOptions) {
            List {
                ForEach(items, id: \.self) { choice in
                    Text(choice)
                }
            }
        }
    }
    
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox(items: .constant(["Hello", "World", "7"]), selectedItem: .constant("Hello"))
    }
}
