//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/4/21.
//

import SwiftUI

public struct ComboBox: View {
    @State var choices: [String]
    @State var selectedItemIndex: Int
    
    public var selectedItem: String {
        return choices[selectedItemIndex]
    }
    
    public var body: some View {
        NavigationView {
            NavigationLink(destination: ComboBoxList(choices: choices, selectedItemIndex: $selectedItemIndex)) {
                Text(selectedItem)
            }
        }
    }
    
    public init(choices: [String], selectedItemIndex: Int = 0) {
        self.choices = choices
        self.selectedItemIndex = selectedItemIndex
    }
}

struct ComboBox_Previews: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: ["Hello", "World", "7"])
    }
}
