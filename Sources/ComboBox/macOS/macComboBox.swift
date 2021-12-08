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
    
    @State private var showOptions = false
    
    var selectionBinding: Binding<String> {
        Binding(get: {
            return selectedItem
        }, set: { value in
            if !items.contains(where: { item in
                item.caseInsensitiveCompare(value) == .orderedSame
            }) {
                items.append(value)
            }
            
            selectedItem = value
        })
    }
    
    var body: some View {
        HStack {
            TextField("", text: selectionBinding)
            Button(action: {
                showOptions.toggle()
            }) {
                Image(systemName: "chevron.down")
            }.accessibilityLabel("expand")
        }.sheet(isPresented: $showOptions) {
            List {
                ForEach(items, id: \.self) { choice in
                    Text(choice).onTapGesture {
                        selectedItem = choice
                        showOptions = false
                    }
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
