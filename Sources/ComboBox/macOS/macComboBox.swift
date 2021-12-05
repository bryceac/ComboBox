//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/5/21.
//

import SwiftUI
import Appkit

struct macComboBox: NSViewRepresentable {
    @Binding var content: [String]
    var numberOfVisibleItems: Int
    @State var selectedIndex: Int
    
    var selectedItem: String {
        return content[selectedIndex]
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        macComboBox()
    }
}
