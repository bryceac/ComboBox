//
//  SwiftUIView.swift
//  
//
//  Created by Bryce Campbell on 12/3/21.
//

import SwiftUI

public struct ComboBoxRow: View {
    var title: String
    @State var selection: String
    var action: ()-> Void
    
    var isSelected: Bool {
        return selection.caseInsensitiveCompare(title) == .orderedSame
    }
    
    public var body: some View {
        HStack {
            Button(title, action: self.action)
            if isSelected {
                Spacer()
                Image(systemName: "checkmark").foregroundColor(.blue)
            }
        }
    }
}

struct ComboBoxRow_Previews: PreviewProvider {
    static var previews: some View {
        ComboBoxRow(title: "Hello", selection: "", action: {})
    }
}
