//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/4/21.
//

import SwiftUI

public struct ComboBox: View {
    @Binding var choices: [String]
    @Binding var value: String
    
    public var body: some View {
        NavigationView {
            NavigationLink(destination: ComboBoxList(choices: $choices, selectedItem: $value)) {
                Text(value)
            }
        }
    }
    
    public init(choices: Binding<[String]>, value: Binding<String>) {
        self._choices = choices
        self._value = value
    }
}

struct ComboBox_Previews: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: .constant(["Hello", "World", "7"]), value: .constant("Hello"))
    }
}
