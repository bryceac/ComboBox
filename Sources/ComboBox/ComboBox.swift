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
            NavigationLink(destination: ComboBoxList(choices: choices, selectedItem: $value)) {
                Text(value)
            }
        }
    }
    
    public init(choices: [String], value: Binding<String>) {
        self.choices = choices
        self._value = value
    }
}

struct ComboBox_Previews: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: ["Hello", "World", "7"], value: .constant("Hello"))
    }
}
