//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/4/21.
//

import SwiftUI

public struct ComboBox: View {
    @State public var choices: [String]
    @State public var selectedItemIndex: Int = 0
    
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
}

struct ComboBox_Previews: PreviewProvider {
    static var previews: some View {
        ComboBox(choices: ["Hello", "World", "7"])
    }
}
