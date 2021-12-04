//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/4/21.
//

import SwiftUI

struct ComboBox: View {
    @State var choices: [String]
    @State private var selectedItem: String = "Selection"
    
    var body: some View {
        NavigationView {
            NavigationLink(destination: ComboBoxList(choices: choices)) {
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
