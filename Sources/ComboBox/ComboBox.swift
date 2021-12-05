//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/4/21.
//

import SwiftUI

public struct ComboBox: View {
    @State var choices: [String]
    @Binding var value: String
    
    public var body: some View {
        NavigationView {
            NavigationLink(destination: ComboBoxList(choices: choices, selectedItemIndex: $selectedItemIndex)) {
                Text(selectedItem)
            }
        }
    }
    
    public init(choices: [String], selection: Binding<String>) {
        self.choices = choices
        value = selection
    }
}

struct ComboBox_Previews: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: ["Hello", "World", "7"], selectedItemIndex: .constant(0))
    }
}
